require 'spec_helper'
require 'pronounce/syllabification_context'
require 'pronounce/syllable_rules'
require 'pronounce/syllable_rules/base'

module Pronounce
  describe SyllableRules do
    describe 'Sonority Sequencing Principle' do
      subject do
        context = Pronounce::SyllabificationContext.new syllables, phones, index
        SyllableRules[:base]['Sonority Sequencing Principle'].evaluate context
      end

      let(:syllables) { [] }
      let(:phones) { make_phones %w[OW AA NG T R UW F] }

      context 'for a vowel preceded by another vowel' do
        let(:index) { 1 }
        it { is_expected.to be :new_syllable }
      end

      context 'for a consonant followed by a lower sonority phone' do
        let(:syllables) { [make_syllable(%w[OW])] }
        let(:index) { 2 }
        it { is_expected.to be :no_new_syllable }
      end

      context 'for a sonority trough' do
        let(:syllables) { [make_syllable(%w[OW])] }
        let(:index) { 3 }
        it { is_expected.to be :new_syllable }
      end

      context 'for a phone preceded by a lower sonority phone' do
        let(:syllables) { [make_syllable(%w[OW]), make_syllable(%w[AA NG])] }
        let(:index) { 4 }
        it { is_expected.to be :no_new_syllable }
      end

      context 'for a sonority peak' do
        let(:syllables) { [make_syllable(%w[OW]), make_syllable(%w[AA NG])] }
        let(:index) { 5 }
        it { is_expected.to be :no_new_syllable }
      end

      context 'for a consonant preceded by another consonant of equal sonority' do
        let(:phones) { make_phones %w[Y UW1 S F AH0 L] } # useful
        let(:index) { 3 }
        it { is_expected.to be :new_syllable }
      end

      context 'for a final' do
        let(:index) { 4 }

        context 'consonant' do
          let(:phones) { make_phones %w[P AE1 S IH0 NG] } # passing
          let(:syllables) { [make_syllable(%w[P AE1])] }
          it { is_expected.to be :no_new_syllable }
        end

        context 'vowel preceded by a consonant' do
          let(:phones) { make_phones %w[M IH1 L K IY0] } # milky
          let(:syllables) { [make_syllable(%w[M IH1 L])] }
          it { is_expected.to be :no_new_syllable }
        end

        context 'vowel preceded by a consonant that is part of a coda' do
          let(:index) { 3 }
          let(:phones) { make_phones %w[CH EH1 R IY0] } # cherry
          it { is_expected.to be :new_syllable }
        end

        context 'vowel preceded by another vowel' do
          let(:phones) { make_phones %w[HH AH0 W AY1 IY2] } # Hawaii
          let(:syllables) { [make_syllable(%w[HH AH0])] }
          it { is_expected.to be :new_syllable }
        end

      end

      context 'for a phone preceded by a lower sonority phone that is part of a coda' do
        let(:phones) { make_phones %w[IY1 V N IHO NG] } # evening
        let(:index) { 2 }
        it { is_expected.to be :new_syllable }
      end

    end
  end
end
