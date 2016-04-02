# Plagiarism

Search for plagiarism and check the duplication of your content from Bing, Google, Yahoo and DuckDuckGo.

## Installation

```ruby
gem 'plagiarism2', require: 'plagiarism'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install plagiarism2

## Usage

Add in your config

```ruby
Plagiarism.configure do |config|
  config.strategies = [xxx] # => [:google, :bing, :duck, :yahoo]
  config.whitelists = ['www.ring.md']
end
```

+ Using bing engine, you have to set access key (you can get it from [here](https://datamarket.azure.com/dataset/bing/searchweb))

```ruby
config.bing_key = xxx
```

+ Using google engine, you have to set two keys (you can get it from [here](https://developers.google.com/custom-search/json-api/v1/using_rest))

```ruby
config.google_key = xxx
config.google_cx = xx
```

After that you can check the unique of content

```ruby
text = 'Latte user story paradigm affordances experiential innovate venture capital physical computing. Ship it agile actionable insight iterate thought leader pitch deck experiential iterate. Venture capital food-truck quantitative vs. qualitative SpaceTeam convergence agile.'
Plagiarism.unique? text
```

`Plagiarism.unique?` is true when all strategies is true

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MQuy/plagiarism. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

> Disclaim: Yahoo and DuckDuckGo don't support api, therefore plagiarism has to crawl data and they will mark plagiarism as spam as we request too much, if you find any better solution, please help me.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

