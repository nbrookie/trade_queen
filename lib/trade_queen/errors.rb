module TradeQueen
  module Errors
    ERRORS = {
      400 => TradeQueen::Errors::BadRequest,
      401 => TradeQueen::Errors::Unauthorized,
      403 => TradeQueen::Errors::Forbidden,
      404 => TradeQueen::Errors::NotFound,
      406 => TradeQueen::Errors::NotAcceptable,
      422 => TradeQueen::Errors::UnprocessableEntity,
      429 => TradeQueen::Errors::TooManyRequests,
      500 => TradeQueen::Errors::InternalServerError,
      502 => TradeQueen::Errors::BadGateway,
      503 => TradeQueen::Errors::ServiceUnavailable,
      504 => TradeQueen::Errors::GatewayTimeout,
    }.freeze
    private_constant :ERRORS

    def self.fetch_by_code(code)
      ERRORS[code.to_i]
    end
  end
end
