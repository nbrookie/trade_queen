require 'oauth'

module TradeQueen
  module Rest
    class Client
      include TradeQueen::Client

      BASE_URL = 'https://api.tradeking.com'.freeze

      def quotes(*args)
        response = post TradeQueen::Rest::Quote::URL, symbols: args.flatten
        TradeQueen::Collection.new(response, TradeQueen::Rest::Quote)
      end

      def quote(symbol)
        quotes(symbol).first
      end

      private

      def post(url, params)
        response = oauth_access_token.post(url, params, 'Accept' => 'application/json')
        error = TradeQueen::Errors.fetch_by_code(response.code)
        raise error.new(response) if error
        response
      end

      def consumer
        @consumer ||= OAuth::Consumer.new consumer_key, consumer_secret, site: BASE_URL
      end

      def oauth_access_token
        @oauth_access_token ||= OAuth::AccessToken.new(consumer, access_token, access_token_secret)
      end
    end
  end
end
