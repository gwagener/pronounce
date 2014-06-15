require 'pronounce/syllable_rules/rule_result'

module Pronounce::SyllableRules
  describe RuleResult do
    describe '#<=>' do
      it 'ranks results with the same parameters equally' do
        expect(RuleResult.new(:new_syllable, 0)).to eq RuleResult.new(:new_syllable, 0)
      end

      it 'ranks :new_syllable > :no_new_syllable > :not_applicable' do
        expect(RuleResult.new(:new_syllable)).to be > RuleResult.new(:no_new_syllable)
        expect(RuleResult.new(:no_new_syllable)).to be > RuleResult.new(:not_applicable)
        expect(RuleResult.new(:not_applicable)).to be < RuleResult.new(:new_syllable)
      end

      it 'ranks results that accessed earlier phones higher than other applicable results' do
        expect(RuleResult.new(:no_new_syllable, 0)).to be > RuleResult.new(:new_syllable, 1)
        expect(RuleResult.new(:not_applicable, 0)).to be < RuleResult.new(:no_new_syllable, 1)
      end

      it 'fails when trying to compare to a non-RuleResult' do
        expect { RuleResult.new(:new_syllable) > :no_new_syllable }.to raise_error ArgumentError
      end
    end

  end
end
