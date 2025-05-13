# frozen_string_literal: true

module ScraperLib
  # Fetches HTML content using HTTP requests
  class HttpFetcher < Fetcher
    # Fetch HTML content using HTTParty
    # @return [String] The HTML content
    # @raise [FetchError] If fetching fails
    def fetch
      response = HTTParty.get(@url, headers: default_headers.merge(@headers), timeout: @timeout)
      unless response.success?
        raise FetchError, "Failed to fetch #{@url} (HTTP #{response.code}): #{response.message}"
      end

      response.body
    rescue HTTParty::Error => e
      raise FetchError, "HTTP request failed: #{e.message}"
    end
  end
end