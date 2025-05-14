# frozen_string_literal: true

require "test_helper"

class MetaExtractorTest < Minitest::Test
  def setup
    @html = <<~HTML
      <!DOCTYPE html>
      <html>
      <head>
        <title>Test Page</title>
        <meta name="description" content="This is a test page">
        <meta name="keywords" content="test, page, ruby">
        <meta property="og:title" content="Open Graph Title">
        <meta property="og:description" content="Open Graph Description">
      </head>
      <body>
        <h1>Hello World</h1>
      </body>
      </html>
    HTML

    @document = Nokogiri::HTML(@html)
    @extractor = ScraperLib::MetaExtractor.new(@document)
  end

  def test_extract_single_meta_tag_with_array
    result = @extractor.extract(["description"])
    assert_equal "This is a test page", result["description"]
  end

  def test_extract_multiple_meta_tags_with_array
    result = @extractor.extract(["description", "keywords"])
    assert_equal "This is a test page", result["description"]
    assert_equal "test, page, ruby", result["keywords"]
  end

  def test_extract_single_meta_tag_with_json_string
    result = @extractor.extract('["description"]')
    assert_equal "This is a test page", result["description"]
  end

  def test_extract_multiple_meta_tags_with_json_string
    result = @extractor.extract('["description", "keywords"]')
    assert_equal "This is a test page", result["description"]
    assert_equal "test, page, ruby", result["keywords"]
  end

  def test_extract_nonexistent_meta_tag
    result = @extractor.extract(["nonexistent"])
    assert_nil result["nonexistent"]
  end

  def test_extract_open_graph_meta_tags
    result = @extractor.extract(["og:title", "og:description"])
    assert_equal "Open Graph Title", result["og:title"]
    assert_equal "Open Graph Description", result["og:description"]
  end

  def test_extract_open_graph_meta_tags_with_json_string
    result = @extractor.extract('["og:title", "og:description"]')
    assert_equal "Open Graph Title", result["og:title"]
    assert_equal "Open Graph Description", result["og:description"]
  end

  def test_extract_with_non_array_input
    result = @extractor.extract("not-a-json-array")
    assert_equal({}, result)
  end

  def test_extract_with_invalid_json_input
    result = @extractor.extract("{invalid json}")
    assert_equal({}, result)
  end

  def test_extract_with_json_object_instead_of_array
    result = @extractor.extract('{"key": "value"}')
    assert_equal({}, result)
  end
end