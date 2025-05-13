# frozen_string_literal: true

require "test_helper"

class FetcherTest < Minitest::Test
  def setup
    @url = "https://example.com"
    @headers = { "Custom-Header" => "Value" }
    @timeout = 10
  end

  def test_base_fetcher_requires_implementation
    fetcher = ScraperLib::Fetcher.new(@url, @headers, @timeout)
    
    assert_raises(NotImplementedError) do
      fetcher.fetch
    end
  end
  
  def test_default_headers
    fetcher = ScraperLib::Fetcher.new(@url, @headers, @timeout)
    
    # Use send to access protected method
    headers = fetcher.send(:default_headers)
    
    assert_kind_of Hash, headers
    assert_includes headers.keys, "User-Agent"
    assert_includes headers.keys, "Accept"
    assert_includes headers.keys, "Accept-Language"
  end
end