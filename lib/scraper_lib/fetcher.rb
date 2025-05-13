# frozen_string_literal: true

module ScraperLib
  # Base class for HTML fetchers
  class Fetcher
    # @param url [String] The URL to fetch
    # @param headers [Hash] Additional HTTP headers to send with the request
    # @param timeout [Integer] Request timeout in seconds
    def initialize(url, headers, timeout)
      @url = url
      @headers = headers
      @timeout = timeout
    end
    
    # Fetch HTML content from the URL
    # @return [String] The HTML content
    # @raise [FetchError] If fetching fails
    def fetch
      raise NotImplementedError, "Subclasses must implement the fetch method"
    end
    
    protected
    
    def default_headers
      {
        "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36",
        "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
        "Accept-Language" => "en-US,en;q=0.5",
      }
    end
  end
end