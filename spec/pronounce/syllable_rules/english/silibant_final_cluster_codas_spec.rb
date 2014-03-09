require 'spec_helper'
require 'pronounce/syllabification_context'
require 'pronounce/syllable_rules'
require 'pronounce/syllable_rules/english'

module Pronounce
  describe SyllableRules do
    describe 'silibant final cluster codas' do
      subject do
        context = Pronounce::SyllabificationContext.new(syllables, phones, index)
        SyllableRules[:en]['silibant final cluster codas'].evaluate(context)
      end

      let(:syllables) { [] }

      context 'ending in /s/' do
        let(:index) { 7 }
        let(:phones) { make_phones(%w[L IH1 NG G W IH0 S T S]) } # linguists
        let(:syllables) { [make_syllable(%w[L IH1 NG])] }
        it { should be :no_new_syllable }
      end

      context 'ending in /z/' do
        let(:phones) { make_phones(%w[B L AY1 N D Z]) } # blinds
        let(:index) { 4 }
        it { should be :no_new_syllable }
      end

      context 'that are syllable final, but word medial' do
        let(:phones) { make_phones(%w[G AE1 T S B IY0]) } # Gatsby
        let(:index) { 2 }
        it { should be :no_new_syllable }
      end

      context 'not ending in a silibant' do
        let(:phones) { make_phones(%w[L AA1 T K AH0]) } # latka
        let(:index) { 2 }
        it { should be :not_applicable }
      end

    end
  end
end
