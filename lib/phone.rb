module Pronounce
  class Phone
    attr_reader :symbol, :articulation

    def initialize(symbol, articulation)
      @symbol = symbol
      @articulation = articulation
    end

    def self.all
      @all ||= File.read("#{DATA_DIR}/cmudict/cmudict.#{CMUDICT_VERSION}.phones").
                    split("\n").
                    reduce([]){|phones, phone| symbol, articulation = *phone.split("\t"); phones << Phone.new(symbol, articulation) }
    end

    def eql?(phone)
      self.class.equal?(phone.class) && @symbol == phone.symbol
    end
    alias == eql?

    def hash
      @symbol.hash
    end

  end
end
