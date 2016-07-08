module TradeQueen
  module Errors
    class TooManyRequests < Base
      def reset_at
        reset_timestamp = @http_response['x-ratelimit-expire']
        Time.at(reset_timestamp.to_i).utc if reset_timestamp
      end

      def retry_after
        [(reset_at - Time.now).ceil, 0].max if reset_at
      end
    end
  end
end
