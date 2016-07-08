require 'spec_helper'

describe TradeQueen::Client do
  let(:client) do
    TradeQueen::Client.new do |config|
      config.consumer_key = 'foo'
      config.consumer_secret = 'bar'
      config.access_token = 'baz'
      config.access_token_secret = 'goo'
    end
  end

  describe "configuration" do
    describe "when configuring using a block" do
      it "sets each option accordingly" do
        expect(client.consumer_key).to eq 'foo'
        expect(client.consumer_secret).to eq 'bar'
        expect(client.access_token).to eq 'baz'
        expect(client.access_token_secret).to eq 'goo'
      end
    end

    describe "when configuring using a hash" do
      let(:client) do
        TradeQueen::Client.new(
          consumer_key: 'foo',
          consumer_secret: 'bar',
          access_token: 'baz',
          access_token_secret: 'goo'
        )
      end

      it "sets each option accordingly" do
        expect(client.consumer_key).to eq 'foo'
        expect(client.consumer_secret).to eq 'bar'
        expect(client.access_token).to eq 'baz'
        expect(client.access_token_secret).to eq 'goo'
      end

      describe "when configuring using invalid options" do
        let(:client) { TradeQueen::Client.new(scooby_doo:'where are you') }

        it "does not set those options on the client" do
          expect(client.instance_variable_get("@scooby_doo")).to be_nil
        end
      end
    end
  end

  describe "#quotes" do
    let(:response_headers) { { content_type: 'application/json; charset=utf-8' } }

    before do
      stub_post(TradeQueen::Quote::URL)
        .with(body: body)
        .to_return(body: fixture(fixture_name), headers: response_headers)
    end

    describe "when given a single stock ticker" do
      let(:body) { "symbols=aapl" }
      let(:fixture_name) { "single_stock_quote.json" }

      it "fetches the quote for that ticker" do
        result = client.quotes("aapl")
        expect(result.count).to eq 1
        expect(result.first).to be_a TradeQueen::Quote
        expect(result.first.name).to eq "APPLE INC"
      end
    end

    describe "when given an array of stock tickers" do
      let(:body) { "symbols=aapl&symbols=msft" }
      let(:fixture_name) { "double_stock_quote.json" }

      it "fetches the quote for each ticker, coming back in the order they were fetched" do
        result = client.quotes(["aapl", "msft"])
        expect(result.count).to eq 2
        result.each { |r| expect(r).to be_a TradeQueen::Quote }
        expect(result.first.name).to eql "APPLE INC"
        expect(result.last.name).to eql "MICROSOFT CORPORATION"
      end
    end

    describe "when given tickers as multiple arguments" do
      let(:body) { "symbols=aapl&symbols=msft" }
      let(:fixture_name) { "double_stock_quote.json" }

      it "fetches the quote for each ticker" do
        result = client.quotes("aapl", "msft")
        expect(result.count).to eq 2
        result.each { |r| expect(r).to be_a TradeQueen::Quote }
        expect(result.first.name).to eql "APPLE INC"
        expect(result.last.name).to eql "MICROSOFT CORPORATION"
      end
    end

    describe "when too many requests are made and the rate limit is reached" do
      let(:now) { Time.now }
      let(:response_headers) do
        {
          "content_type" => 'application/json; charset=utf-8',
          "x-ratelimit-expire" => [(now + 10).to_i],
          "x-ratelimit-limit" => ["60"],
          "x-ratelimit-remaining" => ["0"],
          "x-ratelimit-used" => ["60"]
        }
      end
      let(:body) { "symbols=aapl" }
      let(:fixture_name) { "too_many_requests.json" }

      before do
        stub_post(TradeQueen::Quote::URL)
          .with(body: body)
          .to_return(body: fixture(fixture_name), status: 429, headers: response_headers)
        Timecop.freeze(now)
      end
      after { Timecop.return }

      it "raises an error and has the amount of time to wait before retrying on the error" do
        expect { client.quotes("aapl") }.to raise_error TradeQueen::Errors::TooManyRequests do |e|
          expect(e.retry_after).to eq 10
        end
      end
    end
  end

  describe "#quote" do
    let(:response_headers) { { content_type: 'application/json; charset=utf-8' } }
    let(:body) { "symbols=aapl" }
    let(:fixture_name) { "single_stock_quote.json" }

    before do
      stub_post(TradeQueen::Quote::URL)
        .with(body: body)
        .to_return(body: fixture(fixture_name), headers: response_headers)
    end

    it "is an alias for #quotes" do
      result = client.quote("aapl")
      expect(result.count).to eq 1
      expect(result.first).to be_a TradeQueen::Quote
      expect(result.first.name).to eq "APPLE INC"
    end
  end
end
