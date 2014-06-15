require 'spec_helper'
require 'pronounce/syllable_rules/rule_set_result'

module Pronounce::SyllableRules
  describe RuleSetResult do
    describe '#<=>' do
      let(:new_syllable_result) { RuleSetResult.new(:lang, :new_syllable) }
      let(:no_new_syllable_result) { RuleSetResult.new(:lang, :no_new_syllable) }
      let(:not_application_result) { RuleSetResult.new(:lang, :not_applicable) }
      let(:base_new_syllable_result) { RuleSetResult.new(:base, :new_syllable) }

      it 'ranks results with the same parameters equally' do
        expect(new_syllable_result).to eq RuleSetResult.new(:lang, :new_syllable)
      end

      it 'ranks :new_syllable > :no_new_syllable > :not_applicable' do
        expect(new_syllable_result).to be > no_new_syllable_result
        expect(no_new_syllable_result).to be > not_application_result
        expect(not_application_result).to be < new_syllable_result
      end

      it 'ranks results of base rules lower than other applicable results' do
        expect(new_syllable_result).to eq RuleSetResult.new(:other_lang, :new_syllable)
        expect(no_new_syllable_result).to be > base_new_syllable_result
        expect(not_application_result).to be < base_new_syllable_result
      end

      it 'fails when trying to compare to a non-RuleSetResult' do
        expect { new_syllable_result > :no_new_syllable }.to raise_error ArgumentError
      end
    end

  end
end
