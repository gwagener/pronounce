require 'spec_helper'
require 'phone'

module Pronounce
  describe Phone do
    describe '.all' do
      it 'lists all English phones' do
        Phone.all.should == {
          Phone.new('AA') => Articulation[:vowel],
          Phone.new('AE') => Articulation[:vowel],
          Phone.new('AH') => Articulation[:vowel],
          Phone.new('AO') => Articulation[:vowel],
          Phone.new('AW') => Articulation[:vowel],
          Phone.new('AY') => Articulation[:vowel],
          Phone.new('B')  => Articulation[:stop],
          Phone.new('CH') => Articulation[:affricate],
          Phone.new('D')  => Articulation[:stop],
          Phone.new('DH') => Articulation[:fricative],
          Phone.new('EH') => Articulation[:vowel],
          Phone.new('ER') => Articulation[:vowel],
          Phone.new('EY') => Articulation[:vowel],
          Phone.new('F')  => Articulation[:fricative],
          Phone.new('G')  => Articulation[:stop],
          Phone.new('HH') => Articulation[:aspirate],
          Phone.new('IH') => Articulation[:vowel],
          Phone.new('IY') => Articulation[:vowel],
          Phone.new('JH') => Articulation[:affricate],
          Phone.new('K')  => Articulation[:stop],
          Phone.new('L')  => Articulation[:liquid],
          Phone.new('M')  => Articulation[:nasal],
          Phone.new('N')  => Articulation[:nasal],
          Phone.new('NG') => Articulation[:nasal],
          Phone.new('OW') => Articulation[:vowel],
          Phone.new('OY') => Articulation[:vowel],
          Phone.new('P')  => Articulation[:stop],
          Phone.new('R')  => Articulation[:liquid],
          Phone.new('S')  => Articulation[:fricative],
          Phone.new('SH') => Articulation[:fricative],
          Phone.new('T')  => Articulation[:stop],
          Phone.new('TH') => Articulation[:fricative],
          Phone.new('UH') => Articulation[:vowel],
          Phone.new('UW') => Articulation[:vowel],
          Phone.new('V')  => Articulation[:fricative],
          Phone.new('W')  => Articulation[:semivowel],
          Phone.new('Y')  => Articulation[:semivowel],
          Phone.new('Z')  => Articulation[:fricative],
          Phone.new('ZH') => Articulation[:fricative]
        }
      end
    end

    describe '.new' do
      it 'fails if symbol is not in Pronounce.symbols' do
        expect { Phone.new 'ZA' }.to raise_error ArgumentError
      end
    end

    describe '#<=>' do
      it 'is based on sonority' do
        expect(Phone.new 'AH').to eq Phone.new('UW')
        expect(Phone.new 'P').to be <  Phone.new('CH')
        expect(Phone.new 'F').to be <= Phone.new('Z')
        expect(Phone.new 'M').to be >= Phone.new('N')
        expect(Phone.new 'W').to be >  Phone.new('R')
      end

      it 'fails when trying to compare to a non-Phone' do
        expect { Phone.new('P') < 'CH' }.to raise_error ArgumentError
      end
    end

    describe '#eql?' do
      let(:phone) { Phone.new 'AH' }

      it 'is true for an instance of the same phone' do
        expect(phone).to eql Phone.new 'AH'
      end

      it 'is false for an instance of a different phone' do
        expect(phone).to_not eql Phone.new 'UW'
      end

      it 'is false for a non-Phone' do
        expect(phone).to_not eql 'AH'
      end
    end

    describe '#hash' do
      let(:phone) { Phone.new('AH').hash }

      it 'is the same for an instance of the same phone' do
        expect(phone).to eq Phone.new('AH').hash
      end

      it 'is different for an instance of a different phone' do
        expect(phone).to_not eq Phone.new('UW').hash
      end

      it 'is different for a non-Phone' do
        expect(phone).to_not eq 'AH'.hash
      end
    end

    describe '#inspect' do
      it 'returns the name only' do
        expect(Phone.new('AE2').inspect).to eq 'AE'
      end
    end

    describe '#stress' do
      it 'is an integer' do
        Phone.new('OY2').stress.should == 2
      end

      it 'is nil for consonants' do
        Phone.new('ZH').stress.should be_nil
      end
    end

    describe '#syllabic?' do
      it 'is true for vowels' do
        Phone.new('AA').syllabic?.should be_true
      end

      it 'is false for consonants' do
        Phone.new('ZH').syllabic?.should be_false
      end
    end

    describe '#to_s' do
      it 'includes the name and stress' do
        Phone.new('OY2').to_s.should == 'OY2'
      end
    end

  end
end
