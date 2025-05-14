# frozen_string_literal: true

module ScraperLib
  # Factory for creating appropriate extractors
  class ExtractorFactory
    # Create an appropriate extractor based on the field name
    # @param document [Nokogiri::HTML::Document] The parsed HTML document
    # @param field_name [Symbol, String] The name of the field to extract
    # @return [Extractor] An appropriate extractor instance
    def self.create(document, field_name)
      case field_name.to_s
      when 'meta'
        MetaExtractor.new(document)
      else
        CssExtractor.new(document)
      end
    end
  end
end