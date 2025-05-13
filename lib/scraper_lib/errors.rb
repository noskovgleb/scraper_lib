# frozen_string_literal: true

module ScraperLib
  # Base error class for all ScraperLib errors
  class Error < StandardError; end
  
  # Error raised when fetching a URL fails
  class FetchError < Error; end
  
  # Error raised when parsing HTML fails
  class ParseError < Error; end
end