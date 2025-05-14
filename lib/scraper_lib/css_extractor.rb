# frozen_string_literal: true

module ScraperLib
  # Extracts content using CSS selectors
  class CssExtractor < Extractor
    # Extract content using a CSS selector
    # @param selector [String] The CSS selector
    # @return [String, nil] The extracted text content or nil if not found
    def extract(selector)
      @document.at_css(selector)&.text&.strip
    end
  end
end