module TradeQueen
  module Errors
    class Base < StandardError
      attr_reader :code, :http_response
      def initialize(http_response)
        super(http_response.body)
        @http_response = http_response
        @code = http_response.code
      end
    end
  end
end
