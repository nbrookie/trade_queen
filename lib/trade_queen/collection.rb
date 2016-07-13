require 'json'

module TradeQueen
  class Collection
    include Enumerable

    def initialize(response, wrapper_klass)
      @response = response
      @parsed_body = JSON.parse(response.body)
      @wrapper_klass = wrapper_klass
    end

    def each
      if block_given?
        collection.each { |obj| yield obj }
      else
        enum_for(:each)
      end
    end

    def last
      collection.last
    end

    private

    def collection
      @collection ||= raw_collection.map { |obj| @wrapper_klass.new(obj) }
    end

    def raw_collection
      @raw_collection ||= [@parsed_body.dig(*@wrapper_klass.body_keys)].flatten(1)
    end
  end
end
