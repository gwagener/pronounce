module Pronounce
  class Phone
    attr_reader :symbol

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

    def sonority
      @@sonorance ||= {
        'aspirate' => 0, # this is a guess
        'stop' => 1,
        'affricate' => 2,
        'fricative' => 3,
        'nasal' => 4,
        'liquid' => 5,
        'semivowel' => 6,
        'vowel' => 7
      }
      @@sonorance[@articulation]
    end

  end
end
