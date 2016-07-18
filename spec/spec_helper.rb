$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'trade_queen'
require 'webmock/rspec'

def fixture(file)
  File.new("#{File.expand_path('../fixtures', __FILE__)}/#{file}").read
end

def stub_post(url)
  stub_request(:post, TradeQueen::Rest::Client::BASE_URL + url)
end
