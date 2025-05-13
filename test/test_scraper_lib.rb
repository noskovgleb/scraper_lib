# frozen_string_literal: true

require "test_helper"

class TestScraperLib < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ScraperLib::VERSION
  end

  def test_client_initialization
    client = ::ScraperLib::Client.new("https://example.com")
    assert_instance_of ::ScraperLib::Client, client
  end
end
