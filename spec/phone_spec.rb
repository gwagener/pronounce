require 'spec_helper'
require 'phone'

module Pronounce
  describe Phone do
    describe '.all' do
      it 'lists all English phones' do
        Phone.all.should == {
          Phone.create('AA') => Articulation[:vowel],
          Phone.create('AE') => Articulation[:vowel],
          Phone.create('AH') => Articulation[:vowel],
          Phone.create('AO') => Articulation[:vowel],
          Phone.create('AW') => Articulation[:vowel],
          Phone.create('AY') => Articulation[:vowel],
          Phone.create('B')  => Articulation[:stop],
          Phone.create('CH') => Articulation[:affricate],
          Phone.create('D')  => Articulation[:stop],
          Phone.create('DH') => Articulation[:fricative],
          Phone.create('EH') => Articulation[:vowel],
          Phone.create('ER') => Articulation[:vowel],
          Phone.create('EY') => Articulation[:vowel],
          Phone.create('F')  => Articulation[:fricative],
          Phone.create('G')  => Articulation[:stop],
          Phone.create('HH') => Articulation[:aspirate],
          Phone.create('IH') => Articulation[:vowel],
          Phone.create('IY') => Articulation[:vowel],
          Phone.create('JH') => Articulation[:affricate],
          Phone.create('K')  => Articulation[:stop],
          Phone.create('L')  => Articulation[:liquid],
          Phone.create('M')  => Articulation[:nasal],
          Phone.create('N')  => Articulation[:nasal],
          Phone.create('NG') => Articulation[:nasal],
          Phone.create('OW') => Articulation[:vowel],
          Phone.create('OY') => Articulation[:vowel],
          Phone.create('P')  => Articulation[:stop],
          Phone.create('R')  => Articulation[:liquid],
          Phone.create('S')  => Articulation[:fricative],
          Phone.create('SH') => Articulation[:fricative],
          Phone.create('T')  => Articulation[:stop],
          Phone.create('TH') => Articulation[:fricative],
          Phone.create('UH') => Articulation[:vowel],
          Phone.create('UW') => Articulation[:vowel],
          Phone.create('V')  => Articulation[:fricative],
          Phone.create('W')  => Articulation[:semivowel],
          Phone.create('Y')  => Articulation[:semivowel],
          Phone.create('Z')  => Articulation[:fricative],
          Phone.create('ZH') => Articulation[:fricative]
        }
      end
    end

    describe '.create' do
      it 'creates an instance of Phone' do
        expect(Phone.create 'OY2').to be_an_instance_of Phone
      end

      it 'fails if symbol is not in Pronounce.symbols' do
        expect { Phone.create 'ZA' }.to raise_error ArgumentError
      end
    end

    describe '#<=>' do
      it 'is based on sonority' do
        Phone.create('AH').should == Phone.create('UW')
        Phone.create('P').should be <  Phone.create('CH')
        Phone.create('F').should be <= Phone.create('Z')
        Phone.create('M').should be >= Phone.create('N')
        Phone.create('W').should be >  Phone.create('R')
      end

      it 'fails when trying to compare to a non-Phone' do
        expect { Phone.create('P') < 'CH' }.to raise_error ArgumentError
      end
    end

    describe '#eql?' do
      subject { Phone.create('AH') }

      it 'is true for an instance of the same phone' do
        should eql Phone.create('AH')
      end

      it 'is false for an instance of a different phone' do
        should_not eql Phone.create('UW')
      end

      it 'is false for a non-Phone' do
        should_not eql 'AH'
      end
    end

    describe '#hash' do
      subject { Phone.create('AH').hash }

      it 'is the same for an instance of the same phone' do
        expect(subject).to eq Phone.create('AH').hash
      end

      it 'is different for an instance of a different phone' do
        expect(subject).to_not eq Phone.create('UW').hash
      end

      it 'is different for a non-Phone' do
        expect(subject).to_not eq 'AH'.hash
      end
    end

    describe '#inspect' do
      it 'returns the name only' do
        expect(Phone.create('AE2').inspect).to eq 'AE'
      end
    end

    describe '#stress' do
      it 'is an integer' do
        Phone.create('OY2').stress.should == 2
      end

      it 'is nil for consonants' do
        Phone.create('ZH').stress.should be_nil
      end
    end

    describe '#syllabic?' do
      it 'is true for vowels' do
        Phone.create('AA').syllabic?.should be_true
      end

      it 'is false for consonants' do
        Phone.create('ZH').syllabic?.should be_false
      end
    end

    describe '#to_s' do
      it 'includes the name and stress' do
        Phone.create('OY2').to_s.should == 'OY2'
      end
    end

  end
end
