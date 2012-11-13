module Pronounce
  CMUDICT_VERSION = '0.7a'
  DATA_DIR = File.dirname(__FILE__) + '/../data'

  class << self
    def how_do_i_pronounce(word)
      @pronouncation_dictionary ||= build_pronuciation_dictionary
      @pronouncation_dictionary[word.downcase]
    end

    def symbols
      @symbols ||= File.read("#{DATA_DIR}/cmudict/cmudict.#{CMUDICT_VERSION}.symbols").
                        split("\r\n")
    end

    def phones
      @phones ||= File.read("#{DATA_DIR}/cmudict/cmudict.#{CMUDICT_VERSION}.phones").
                       split("\n").
                       reduce({}){|phones, phone| phone, type = *phone.split("\t"); phones.merge({phone => type}) }
    end

    private

    def build_pronuciation_dictionary
      dictionary = {}

      File.readlines("#{DATA_DIR}/cmudict/cmudict.#{CMUDICT_VERSION}").each do |line|
        word, *pron = line.strip.split(' ')
        next unless word && !word.empty? && !word[/[^A-Z]+/]
        dictionary[word.downcase] = split_syllables(pron)
      end

      dictionary
    end

    def split_syllables(word)
      word = word.dup
      syllables = []
      (word.length - 1).downto(0).each do |i|
        if new_syllable?(word, i)
          syllables.unshift(word.pop(word.length - i))
        end
      end
      syllables
    end

    def new_syllable?(word, index)
      return true if index == 0

      return false unless index < word.length - 1
      sonority(word[index]) <= sonority(word[index+1]) && sonority(word[index]) < sonority(word[index-1])
    end

    def sonority(symbol)
      @sonorance ||= {
        'aspirate' => 0,
        'stop' => 1,
        'affricate' => 2,
        'fricative' => 3,
        'nasal' => 4,
        'liquid' => 5,
        'semivowel' => 6,
        'vowel' => 7
      }
      @sonorance[self.phones[symbol[0..1]]]
    end

  end
end
