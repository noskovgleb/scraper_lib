# frozen_string_literal: true

require_relative "scraper_lib/version"
require_relative "scraper_lib/errors"
require_relative "scraper_lib/fetcher"
require_relative "scraper_lib/http_fetcher"
require_relative "scraper_lib/browser_fetcher"
require "httparty"
require "nokogiri"
require 'ferrum'
require 'timeout'

module ScraperLib
  class Client
    # Default timeout in seconds
    DEFAULT_TIMEOUT = 30

    # @param url [String] The URL to scrape
    # @param headers [Hash] Additional HTTP headers to send with the request
    # @param use_browser [Boolean] Whether to use a headless browser for JavaScript rendering
    # @param timeout [Integer] Request timeout in seconds
    def initialize(url, headers: {}, use_browser: false, timeout: DEFAULT_TIMEOUT)
      raise ArgumentError, "URL cannot be nil or empty" if url.nil? || url.strip.empty?
      @url = url
      @headers = headers
      @use_browser = use_browser
      @timeout = timeout
    end

    # Scrape data from the webpage using the provided CSS selectors
    # @param fields [Hash] A hash mapping field names to CSS selectors
    # @return [Hash] A hash mapping field names to extracted values
    def scrape(fields = {})
      html = fetch_html
      extract_data(html, fields)
    end

    private

    def fetch_html
      fetcher = create_fetcher

      Timeout.timeout(@timeout) do
        fetcher.fetch
      end
    rescue Timeout::Error
      raise FetchError, "Request timed out after #{@timeout} seconds"
    end

    def create_fetcher
      if @use_browser
        BrowserFetcher.new(@url, @headers, @timeout)
      else
        HttpFetcher.new(@url, @headers, @timeout)
      end
    end

    def extract_data(html, fields)
      doc = Nokogiri::HTML(html)

      fields.each_with_object({}) do |(key, selector), result|
        result[key] = doc.at_css(selector)&.text&.strip
      end
    rescue => e
      raise ParseError, "Failed to parse HTML: #{e.message}"
    end
  end
end
