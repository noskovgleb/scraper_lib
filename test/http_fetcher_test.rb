# frozen_string_literal: true

require "test_helper"
require "webmock/minitest"

class HttpFetcherTest < Minitest::Test
  def setup
    @url = "https://example.com"
    @headers = { "Custom-Header" => "Value" }
    @timeout = 10
    @fetcher = ScraperLib::HttpFetcher.new(@url, @headers, @timeout)
    
    # Disable real HTTP requests
    WebMock.disable_net_connect!
  end
  
  def teardown
    WebMock.reset!
  end
  
  def test_fetch_success
    html_content = "<html><body><h1>Example</h1></body></html>"
    
    stub_request(:get, @url)
      .to_return(status: 200, body: html_content)
    
    result = @fetcher.fetch
    assert_equal html_content, result
  end
  
  def test_fetch_failure_http_error
    stub_request(:get, @url)
      .to_return(status: 404, body: "Not Found")
    
    assert_raises(ScraperLib::FetchError) do
      @fetcher.fetch
    end
  end
  
  def test_fetch_failure_network_error
    stub_request(:get, @url)
      .to_raise(HTTParty::Error.new("Network error"))
    
    assert_raises(ScraperLib::FetchError) do
      @fetcher.fetch
    end
  end
  
  def test_headers_are_merged
    stub_request(:get, @url)
      .with(headers: { "Custom-Header" => "Value" })
      .to_return(status: 200, body: "OK")
    
    @fetcher.fetch
    
    assert_requested :get, @url, headers: { "Custom-Header" => "Value" }
  end
end