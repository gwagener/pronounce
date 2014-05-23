require 'pronounce/syllable_rules/rule_result'

module Pronounce::SyllableRules
  describe RuleResult do
    describe '#<=>' do
      it 'ranks :new_syllable > :no_new_syllable > :not_applicable' do
        expect(RuleResult.new(:new_syllable)).to eq RuleResult.new(:new_syllable)
        expect(RuleResult.new(:new_syllable)).to be > RuleResult.new(:no_new_syllable)
        expect(RuleResult.new(:no_new_syllable)).to be > RuleResult.new(:not_applicable)
        expect(RuleResult.new(:not_applicable)).to be < RuleResult.new(:new_syllable)
      end

      it 'fails when trying to compare to a non-RuleResult' do
        expect { RuleResult.new(:new_syllable) > :no_new_syllable }.to raise_error ArgumentError
      end
    end

  end
end
