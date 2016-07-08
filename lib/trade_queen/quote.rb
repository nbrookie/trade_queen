module TradeQueen
  class Quote
    URL = "/v1/market/ext/quotes.json"

    def initialize(quote_hash)
      @quote_hash = quote_hash
    end

    [
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
    ].each do |quote_method|
      define_method(quote_method) { @quote_hash[quote_method.to_s] }
    end
  end
end
