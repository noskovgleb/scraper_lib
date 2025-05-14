# frozen_string_literal: true

module ScraperLib
  # Fetches HTML content using a headless browser
  class BrowserFetcher < Fetcher
    BROWSER_PATH = "/usr/bin/chromium"

    # Fetch HTML content using Ferrum (headless Chrome)
    # @return [String] The HTML content
    # @raise [FetchError] If fetching fails
    def fetch
      browser = nil
      begin
        browser = create_browser
        browser.headers.set(default_headers.merge(@headers))
        browser.go_to(@url)
        browser.body
      rescue Ferrum::Error => e
        raise FetchError, "Browser-based fetch failed: #{e.message}"
      ensure
        browser&.quit
      end
    end

    private

    def create_browser
      Ferrum::Browser.new(
        path: BROWSER_PATH,
        headless: "new",
        timeout: @timeout,
        browser_options: browser_options
      )
    end

    def browser_options
      {
        'no-sandbox': nil,
        'disable-gpu': nil,
        'disable-dev-shm-usage': nil,
      }
    end
  end
end