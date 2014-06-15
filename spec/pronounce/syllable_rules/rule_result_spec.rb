require 'pronounce/syllable_rules/rule_result'

module Pronounce::SyllableRules
  describe RuleResult do
    describe '#<=>' do
      let(:new_syllable_result) { RuleResult.new(:new_syllable, 0) }
      let(:no_new_syllable_result) { RuleResult.new(:no_new_syllable, 0) }
      let(:not_application_result) { RuleResult.new(:not_applicable, 0) }
      let(:later_new_syllable_result) { RuleResult.new(:new_syllable, 1) }

      it 'ranks results with the same parameters equally' do
        expect(new_syllable_result).to eq RuleResult.new(:new_syllable, 0)
      end

      it 'ranks :new_syllable > :no_new_syllable > :not_applicable' do
        expect(new_syllable_result).to be > no_new_syllable_result
        expect(no_new_syllable_result).to be > not_application_result
        expect(not_application_result).to be < new_syllable_result
      end

      it 'ranks results that accessed earlier phones higher than other applicable results' do
        expect(no_new_syllable_result).to be > later_new_syllable_result
        expect(not_application_result).to be < later_new_syllable_result
      end

      it 'fails when trying to compare to a non-RuleResult' do
        expect { new_syllable_result > :no_new_syllable }.to raise_error ArgumentError
      end
    end

  end
end
