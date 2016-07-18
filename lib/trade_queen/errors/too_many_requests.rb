module TradeQueen
  module Errors
    class TooManyRequests < Base
      def retry_after
        @http_response['x-ratelimit-retry-after'].to_i
      end
    end
  end
end
