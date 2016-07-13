module TradeQueen
  module Rest
    class Quote
      URL = "/v1/market/ext/quotes.json"

      ATTRS = [
        :adp_100, :adp_200, :adp_50, :adv_21, :adv_30, :adv_90, :ask, :ask_time, :asksz, :basis, :beta,
        :bid, :bid_time, :bidsz, :bidtick, :chg, :chg_sign, :chg_t, :cl, :contract_size, :cusip, :date,
        :datetime, :days_to_expiration, :div, :divexdate, :divfreq, :divpaydt, :dollar_value, :eps,
        :exch, :exch_desc, :hi, :iad, :idelta, :igamma, :imp_volatility, :incr_vl, :irho, :issue_desc,
        :itheta, :ivega, :last, :lo, :name, :op_delivery, :op_flag, :op_style, :op_subclass, :openinterest,
        :opn, :opt_val, :pchg, :pchg_sign, :pcls, :pe, :phi, :plo, :popn, :pr_adp_100, :pr_adp_200,
        :pr_adp_50, :pr_date, :pr_openinterest, :prbook, :prchg, :prem_mult, :put_call, :pvol, :qcond,
        :rootsymbol, :secclass, :sesn, :sho, :strikeprice, :symbol, :tcond, :timestamp, :tr_num, :tradetick,
        :trend, :under_cusip, :undersymbol, :vl, :volatility12, :vwap, :wk52hi, :wk52hidate, :wk52lo,
        :wk52lodate, :xdate, :xday, :xmonth, :xyear, :yield
      ].freeze

      attr_reader *ATTRS

      # the keys to dig into the json response which looks like:
      # {
      #   "response": {
      #      "quotes": {
      #        "quote": [{quote1}, {quote2},...]
      #      }
      #   }
      # }
      def self.body_keys
        ["response", "quotes", "quote"]
      end

      def initialize(parsed_quote)
        @parsed_quote = parsed_quote
        ATTRS.each { |key| instance_variable_set("@#{key}", parsed_quote[key.to_s]) }
      end

      def not_found?
        !found?
      end

      def found?
        name != "NA"
      end
    end
  end
end
