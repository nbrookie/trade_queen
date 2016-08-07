require 'spec_helper'

describe TradeQueen::Rest::Quote do
  describe "#not_found?" do
    describe "when a quote has a name of NA and closing price of NA" do
      let(:quote) { TradeQueen::Rest::Quote.new("name" => "NA", "cl" => "NA") }

      it "returns true" do
        expect(quote).to be_not_found
      end
    end

    describe "when a quote does not have a name of NA but does have a closing price of NA" do
      let(:quote) { TradeQueen::Rest::Quote.new("name" => "APPLE INC", "cl" => "NA") }

      it "returns false" do
        expect(quote).to be_not_found
      end
    end

    describe "when a quote has a name of NA but does not have a closing price of NA" do
      let(:quote) { TradeQueen::Rest::Quote.new("name" => "NA", "cl" => "123") }

      it "returns false" do
        expect(quote).to be_not_found
      end
    end

    describe "when a quote does not have a name of NA and does not have a closing price of NA" do
      let(:quote) { TradeQueen::Rest::Quote.new("name" => "APPLE INC", "cl" => "123") }

      it "returns false" do
        expect(quote).to_not be_not_found
      end
    end
  end

  describe "#found?" do
    describe "when a quote has a name of NA" do
      let(:quote) { TradeQueen::Rest::Quote.new("name" => "NA", "cl" => "NA") }

      it "returns false" do
        expect(quote).to_not be_found
      end
    end

    describe "when a quote does not have a name of NA but has a closing price of NA" do
      let(:quote) { TradeQueen::Rest::Quote.new("name" => "APPLE INC", "cl" => "NA") }

      it "returns false" do
        expect(quote).to_not be_found
      end
    end
    describe "when a quote does not have a name of NA or closing price of NA" do
      let(:quote) { TradeQueen::Rest::Quote.new("name" => "APPLE INC", "cl" => "123") }

      it "returns true" do
        expect(quote).to be_found
      end
    end
  end
end
