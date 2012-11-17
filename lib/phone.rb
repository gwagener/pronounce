module Pronounce
  class Phone
    def initialize(symbol, articulation)
      @symbol = symbol
      @articulation = articulation
    end

    class << self
      def all
        self.phones.values
      end

      def find(symbol)
        self.phones[symbol[0..1]]
      end

      protected

      def phones
        @phones ||= File.read("#{DATA_DIR}/cmudict/cmudict.#{CMUDICT_VERSION}.phones").
                         split("\n").
                         reduce({}) do |phones, phone|
                           symbol, articulation = *phone.split("\t")
                           phones.merge({symbol => Phone.new(symbol, articulation)})
                         end
      end

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

    protected

    attr_reader :symbol

  end
end
