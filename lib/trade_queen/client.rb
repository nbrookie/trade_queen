module TradeQueen
  class Client
    VALID_OPTIONS = [:access_token, :access_token_secret, :consumer_key, :consumer_secret]
    attr_accessor *VALID_OPTIONS

    def initialize(options = {})
      VALID_OPTIONS.each do |option_name|
        value = options[option_name]
        instance_variable_set("@#{option_name}", value)
      end

      yield(self) if block_given?
    end
  end
end
