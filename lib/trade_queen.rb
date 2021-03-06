require "trade_queen/version"
require "trade_queen/client"
require "trade_queen/collection"

#require the rest namespace
require "trade_queen/rest/client"
require "trade_queen/rest/quote"

#require the errors namespace (before requiring the parent trade_queen/errors) module
require "trade_queen/errors/base"
require "trade_queen/errors/bad_gateway"
require "trade_queen/errors/bad_request"
require "trade_queen/errors/forbidden"
require "trade_queen/errors/gateway_timeout"
require "trade_queen/errors/internal_server_error"
require "trade_queen/errors/not_acceptable"
require "trade_queen/errors/not_found"
require "trade_queen/errors/service_unavailable"
require "trade_queen/errors/too_many_requests"
require "trade_queen/errors/unauthorized"
require "trade_queen/errors/unprocessable_entity"
require "trade_queen/errors"
