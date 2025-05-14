# frozen_string_literal: true
require 'json'

module ScraperLib
  # Extracts metadata from HTML meta tags
  class MetaExtractor < Extractor
    # Extract metadata from meta tags
    # @param meta_names [String, Array<String>] JSON string or Array of meta tag names to extract
    # @return [Hash] Hash mapping meta tag names to their content
    def extract(meta_names)
      # Handle different input types
      names_array = if meta_names.is_a?(String)
                      begin
                        parsed = JSON.parse(meta_names)
                        parsed.is_a?(Array) ? parsed : []
                      rescue JSON::ParserError
                        []
                      end
                    elsif meta_names.is_a?(Array)
                      meta_names
                    else
                      []
                    end

      # Return empty hash if we couldn't get a valid array
      return {} if names_array.empty?

      # Process each meta tag name
      names_array.each_with_object({}) do |name, result|
        # Try to find meta tag by name attribute
        node = @document.at_css("meta[name='#{name}']")

        # If not found by name, try property attribute (for Open Graph tags)
        node ||= @document.at_css("meta[property='#{name}']") if name.start_with?('og:')

        result[name] = node&.[]('content')&.strip
      end
    end
  end
end