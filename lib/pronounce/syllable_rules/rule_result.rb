module Pronounce
  module SyllableRules
    class RuleResult
      include Comparable

      attr_reader :value

      def initialize(value)
        @value = value
      end

      def <=>(other)
        return unless self.class === other

        compare_by_applicability(other.value) ||
        compare_by_value(other.value)
      end

      private

      def compare_by_applicability(other_value)
        if [value, other_value].one? { |v| v == :not_applicable }
          if value == :not_applicable
            -1
          else
            1
          end
        end
      end

      def compare_by_value(other_value)
        case value
        when other_value
          0
        when :new_syllable
          1
        else
          -1
        end
      end

    end
  end
end
