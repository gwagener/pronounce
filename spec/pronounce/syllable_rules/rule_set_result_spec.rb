require 'pronounce/syllable_rules/rule_set_result'

module Pronounce::SyllableRules
  describe RuleSetResult do
    describe '#<=>' do
      it 'ranks :new_syllable > :no_new_syllable > :not_applicable' do
        expect(RuleSetResult.new(:lang, :new_syllable)).to eq RuleSetResult.new(:lang, :new_syllable)
        expect(RuleSetResult.new(:lang, :new_syllable)).to be > RuleSetResult.new(:lang, :no_new_syllable)
        expect(RuleSetResult.new(:lang, :no_new_syllable)).to be > RuleSetResult.new(:lang, :not_applicable)
        expect(RuleSetResult.new(:lang, :not_applicable)).to be < RuleSetResult.new(:lang, :new_syllable)
      end

      it 'ranks results of base rules lower than other applicable results' do
        expect(RuleSetResult.new('a rule', :new_syllable)).to eq RuleSetResult.new('another rule', :new_syllable)
        expect(RuleSetResult.new(:lang, :no_new_syllable)).to be > RuleSetResult.new(:base, :new_syllable)
        expect(RuleSetResult.new(:lang, :not_applicable)).to be < RuleSetResult.new(:base, :no_new_syllable)
      end

      it 'fails when trying to compare to a non-RuleResult' do
        expect { RuleSetResult.new(:lang, :new_syllable) > :no_new_syllable }.to raise_error ArgumentError
      end
    end

  end
end
