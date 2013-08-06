require 'pronounce'
require 'articulation'
require 'data_reader'

module Pronounce
  class Phone
    SHORT_VOWELS = %w[AE AH EH IH UH]

    include Comparable

    class << self
      def all
        phone_constructors.values.each_with_object({}) {|fn, all|
          phone = fn.call nil
          all[phone] = phone.articulation
        }
      end

      def new(symbol)
        name = symbol[0..1]
        if phone_constructors.has_key? name
          phone_constructors[name].call symbol[2]
        else
          raise ArgumentError.new 'invalid symbol'
        end
      end

      private

      def phone_constructors
        @fns ||= DataReader.phones.each_with_object({}) {|line, fns|
          name, articulation = *line.strip.split("\t")
          fns[name] = phone_constructor_fn name, articulation
        }
      end

      def phone_constructor_fn(name, articulation)
        ->(stress) do
          phone = allocate
          phone.send :initialize, name, articulation, stress
          phone
        end
      end

    end

    attr_reader :articulation, :stress

    def initialize(name, articulation, stress)
      @name = name
      @articulation = Articulation[articulation.to_sym]
      @stress = stress.to_i if stress
    end

    def <=>(phone)
      articulation <=> phone.articulation if Phone === phone
    end

    def eql?(phone)
      return false unless Phone === phone
      name == phone.name
    end

    def hash
      "#{self.class}:#{name}".hash
    end

    def inspect
      name
    end

    def short?
      SHORT_VOWELS.include? name
    end

    def syllabic?
      articulation.syllabic?
    end

    def to_s
      "#{name}#{stress}"
    end

    protected

    attr_reader :name

  end
end
