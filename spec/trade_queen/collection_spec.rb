require 'spec_helper'

describe TradeQueen::Collection do
  let(:response) { double body: fixture("double_stock_quote.json")}
  let(:wrapper_klass) do 
    Class.new do
      def initialize(*args); end
      def self.body_keys; ["response", "quotes", "quote"] end
    end
  end
  let(:collection) { TradeQueen::Collection.new(response, wrapper_klass) }

  describe "#each" do
    describe "when given a block" do
      it "yields for each element in the collection" do
        expect { |b| collection.each(&b) }.to yield_control.twice
      end
    end

    describe "when not given a block" do
      it "returns an Enumerator" do
        expect(collection.each).to be_a Enumerator
      end
    end
  end
end
