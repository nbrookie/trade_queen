require 'spec_helper'

describe TradeQueen::Client do
  describe "configuration" do
    describe "when configuring using a block" do
      let(:client) do
        TradeQueen::Client.new do |config|
          config.consumer_key = 'foo'
          config.consumer_secret = 'bar'
          config.access_token = 'baz'
          config.access_token_secret = 'goo'
        end
      end

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
    describe "when given a single stock ticker" do
      it "fetches the quote for that ticker" do

      end
    end

    describe "when given a list of stock tickers" do
      it "fetches the quote for each ticker" do

      end
    end
  end

  describe "#quote" do
    it "is an alias for #quotes" do

    end
  end
end
