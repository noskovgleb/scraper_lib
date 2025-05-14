# frozen_string_literal: true

require "test_helper"

class ExtractorFactoryTest < Minitest::Test
  def setup
    @document = Nokogiri::HTML("<html></html>")
  end
  
  def test_create_meta_extractor
    extractor = ScraperLib::ExtractorFactory.create(@document, :meta)
    assert_instance_of ScraperLib::MetaExtractor, extractor
  end
  
  def test_create_meta_extractor_with_string_key
    extractor = ScraperLib::ExtractorFactory.create(@document, "meta")
    assert_instance_of ScraperLib::MetaExtractor, extractor
  end
  
  def test_create_css_extractor_for_other_fields
    extractor = ScraperLib::ExtractorFactory.create(@document, :title)
    assert_instance_of ScraperLib::CssExtractor, extractor
    
    extractor = ScraperLib::ExtractorFactory.create(@document, :price)
    assert_instance_of ScraperLib::CssExtractor, extractor
  end
end