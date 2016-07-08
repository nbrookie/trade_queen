require 'oauth'
require 'json'

module TradeQueen
  class Client
    BASE_URL = 'https://api.tradeking.com'
    VALID_OPTIONS = [:access_token, :access_token_secret, :consumer_key, :consumer_secret]

    attr_accessor *VALID_OPTIONS

    def initialize(options = {})
      VALID_OPTIONS.each do |option_name|
        value = options[option_name]
        instance_variable_set("@#{option_name}", value)
      end

      yield(self) if block_given?
      consumer = OAuth::Consumer.new consumer_key, consumer_secret, site: BASE_URL
      @oauth_access_token = OAuth::AccessToken.new(consumer, access_token, access_token_secret)
    end

    def quotes(*args)
      response_body = post TradeQueen::Quote::URL, symbols: args.flatten
      [response_body["response"]["quotes"]["quote"]].flatten(1).map { |quote| TradeQueen::Quote.new(quote) }
    end
    alias quote quotes

    private

    def post(url, params)
      http_response = @oauth_access_token.post(url, params, 'Accept' => 'application/json')
      error = TradeQueen::Errors.fetch_by_code(http_response.code)
      raise error.new(http_response) if error
      JSON.parse(http_response.body)
    end
  end
end
