# frozen_string_literal: true

require "test_helper"

class ScraperLibTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ScraperLib::VERSION
  end

  def test_client_initialization_with_valid_url
    client = ScraperLib::Client.new("https://example.com")
    assert_instance_of ScraperLib::Client, client
  end

  def test_client_initialization_with_invalid_url
    assert_raises ArgumentError do
      ScraperLib::Client.new("")
    end
  end

  def test_scrape_with_http_request
    # Mock HTTParty to avoid actual HTTP requests
    mock_response = Minitest::Mock.new
    mock_response.expect :success?, true
    mock_response.expect :body, "<html><body><h1>Test Page</h1></body></html>"

    HTTParty.stub :get, mock_response do
      client = ScraperLib::Client.new("https://example.com", use_browser: false)
      result = client.scrape({ "title" => "h1" })
      
      assert_equal "Test Page", result["title"]
    end
  end

  def test_http_error_handling
    # Mock HTTParty to simulate an error
    mock_response = Minitest::Mock.new
    mock_response.expect :success?, false
    mock_response.expect :code, 404
    mock_response.expect :message, "Not Found"

    HTTParty.stub :get, mock_response do
      client = ScraperLib::Client.new("https://example.com", use_browser: false)
      
      assert_raises ScraperLib::FetchError do
        client.scrape({ "title" => "h1" })
      end
    end
  end
end