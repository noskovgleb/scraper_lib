# ScraperLib

A simple web scraping library for Ruby that provides a clean interface for extracting data from websites using Nokogiri and HTTParty.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add scraper_lib
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install scraper_lib
```

## Usage

```ruby
require 'scraper_lib'

# Initialize a client with the target URL
client = ScraperLib::Client.new('https://example.com')

# Define the fields you want to extract with CSS selectors
fields = {
  title: 'h1.title',
  description: 'div.description',
  price: 'span.price',
  meta: ['description', 'keywords'] # For meta tags
}

# Scrape the page
result = client.scrape(fields)

# Access the extracted data
puts result[:title]
puts result[:description]
puts result[:price]
puts result[:meta]['description']
puts result[:meta]['keywords']
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/glebnos/scraper_lib. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/glebnos/scraper_lib/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ScraperLib project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/glebnos/scraper_lib/blob/master/CODE_OF_CONDUCT.md).
