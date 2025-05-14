# frozen_string_literal: true

require "test_helper"

class CssExtractorTest < Minitest::Test
  def setup
    @html = <<~HTML
      <!DOCTYPE html>
      <html>
      <head>
        <title>Test Page</title>
      </head>
      <body>
        <h1 class="title">Hello World</h1>
        <div class="content">
          <p>This is a paragraph</p>
          <span class="price">$10.99</span>
        </div>
      </body>
      </html>
    HTML
    
    @document = Nokogiri::HTML(@html)
    @extractor = ScraperLib::CssExtractor.new(@document)
  end
  
  def test_extract_with_valid_selector
    result = @extractor.extract("h1.title")
    assert_equal "Hello World", result
  end
  
  def test_extract_with_nested_selector
    result = @extractor.extract("div.content p")
    assert_equal "This is a paragraph", result
  end
  
  def test_extract_with_invalid_selector
    result = @extractor.extract("h2.nonexistent")
    assert_nil result
  end
  
  def test_extract_strips_whitespace
    # Add a document with extra whitespace
    html = '<div class="padded">  Extra Whitespace  </div>'
    doc = Nokogiri::HTML(html)
    extractor = ScraperLib::CssExtractor.new(doc)
    
    result = extractor.extract("div.padded")
    assert_equal "Extra Whitespace", result
  end
end