require 'spec_helper'

describe TradeQueen::Rest::Quote do
  describe "#not_found?" do
    describe "when a quote has a name of NA" do
      let(:quote) { TradeQueen::Rest::Quote.new("name" => "NA") }

      it "returns true" do
        expect(quote).to be_not_found
      end
    end

    describe "when a quote does not have a name of NA" do
      let(:quote) { TradeQueen::Rest::Quote.new("name" => "APPLE INC") }

      it "returns false" do
        expect(quote).to_not be_not_found
      end
    end
  end

  describe "#found?" do
    describe "when a quote has a name of NA" do
      let(:quote) { TradeQueen::Rest::Quote.new("name" => "NA") }

      it "returns false" do
        expect(quote).to_not be_found
      end
    end

    describe "when a quote does not have a name of NA" do
      let(:quote) { TradeQueen::Rest::Quote.new("name" => "APPLE INC") }

      it "returns true" do
        expect(quote).to be_found
      end
    end
  end
end
