# frozen_string_literal: true

module ScraperLib
  # Base class for content extractors
  class Extractor
    # @param document [Nokogiri::HTML::Document] The parsed HTML document
    def initialize(document)
      @document = document
    end
    
    # Extract content based on the provided selector
    # @param selector [String, Array, Hash] The selector to use for extraction
    # @return [String, Hash, nil] The extracted content
    def extract(_selector)
      raise NotImplementedError, "Subclasses must implement the extract method"
    end
  end
end