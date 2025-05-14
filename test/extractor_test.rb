# frozen_string_literal: true

require "test_helper"

class ExtractorTest < Minitest::Test
  def setup
    @html = <<~HTML
      <!DOCTYPE html>
      <html>
      <head>
        <title>Test Page</title>
        <meta name="description" content="This is a test page">
        <meta name="keywords" content="test, page, ruby">
        <meta property="og:title" content="Open Graph Title">
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
  end
  
  def test_base_extractor_requires_implementation
    extractor = ScraperLib::Extractor.new(@document)
    
    assert_raises(NotImplementedError) do
      extractor.extract("selector")
    end
  end
end