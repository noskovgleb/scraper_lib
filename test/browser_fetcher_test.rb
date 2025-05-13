# frozen_string_literal: true

require "test_helper"

class BrowserFetcherTest < Minitest::Test
  def setup
    @url = "https://example.com"
    @headers = { "Custom-Header" => "Value" }
    @timeout = 10
    @fetcher = ScraperLib::BrowserFetcher.new(@url, @headers, @timeout)
  end

  def test_browser_options
    # Use send to access private method
    options = @fetcher.send(:browser_options)

    assert_kind_of Hash, options
    assert_includes options.keys, :'no-sandbox'
    assert_includes options.keys, :'disable-gpu'
    assert_includes options.keys, :'disable-dev-shm-usage'
  end

  def test_fetch_with_browser
    # Mock Ferrum::Browser to avoid actual browser instantiation
    mock_browser = Minitest::Mock.new
    mock_headers = Minitest::Mock.new
    mock_network = Minitest::Mock.new

    # Set up expectations
    mock_browser.expect :headers, mock_headers
    mock_browser.expect :go_to, nil, [@url]
    mock_browser.expect :network, mock_network
    mock_browser.expect :body, "<html><body>Test</body></html>"
    mock_browser.expect :quit, nil

    mock_headers.expect :set, nil, [Hash]
    mock_network.expect :wait_for_idle, nil

    # Stub browser creation
    Ferrum::Browser.stub :new, mock_browser do
      result = @fetcher.fetch
      assert_equal "<html><body>Test</body></html>", result
    end

    # Verify all expectations were met
    mock_browser.verify
    mock_headers.verify
    mock_network.verify
  end

  def test_fetch_error_handling
    mock_browser = Minitest::Mock.new
    mock_browser.expect :headers, nil do
      raise Ferrum::Error.new("Browser error")
    end
    mock_browser.expect :quit, nil

    Ferrum::Browser.stub :new, mock_browser do
      assert_raises(ScraperLib::FetchError) do
        @fetcher.fetch
      end
    end
  end
end