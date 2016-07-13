require 'spec_helper'

describe TradeQueen::Client do
  let(:client_klass) { Class.new { include TradeQueen::Client } }
  let(:client) do
    client_klass.new do |config|
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
        client_klass.new(
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
        let(:client) { client_klass.new(scooby_doo:'where are you') }

        it "does not set those options on the client" do
          expect(client.instance_variable_get("@scooby_doo")).to be_nil
        end
      end
    end
  end
end
