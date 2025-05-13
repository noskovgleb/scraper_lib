# frozen_string_literal: true

require_relative "lib/scraper_lib/version"

Gem::Specification.new do |spec|
  spec.name = "scraper_lib"
  spec.version = ScraperLib::VERSION
  spec.authors = ["Gleb N."]
  spec.email = ["noskovgleb@gmail.com"]

  spec.summary = "A simple web scraping library for Ruby"
  spec.description = "ScraperLib provides a clean interface for extracting data from websites using Nokogiri and HTTParty"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage

  spec.files       = Dir['lib/**/*', 'LICENSE', 'README.md']
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty"
  spec.add_dependency "nokogiri"
  spec.add_dependency "ferrum"
  spec.add_dependency "webmock"
end
