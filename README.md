# TradeQueen

A Ruby client for the TradeKing API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'trade_queen'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install trade_queen

## Configuration

Configure a client using hash syntax:

```ruby
client = TradeQueen::Rest::Client.new(
  consumer_key: "an application's consumer key",
  consumer_secret: "an application's consumer secret",
  access_token: "a user's access token",
  access_token_secret: "a user's access secret"
)
```

Configure a client using block syntax:

```ruby
client = TradeQueen::Rest::Client.new do |config|
  config.consumer_key = "an application's consumer key",
  config.consumer_secret = "an application's consumer secret",
  config.access_token = "a user's access token",
  config.access_token_secret = "a user's access secret"
end
```

#### Usage Examples
After initializing a `client`, you can do the following:

**Fetch quotes**

```ruby
#Fetch a single quote
client.quote("aapl") # pass a string
client.quote(:aapl) # pass a symbol

#Fetch multiple quotes
client.quotes(["aapl", :msft])
client.quotes(:aapl, :msft)
```

[TradeKing documentation](https://developers.tradeking.com/documentation/market-ext-quotes-get-post)


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/trade_queen. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

