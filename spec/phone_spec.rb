require_relative '../lib/phone'

module Pronounce
  describe Phone do
    describe ".all" do
      it 'lists all phones with manner of articulation' do
        Phone.all.should == [Phone.new('AA', 'vowel'),
                             Phone.new('AE', 'vowel'),
                             Phone.new('AH', 'vowel'),
                             Phone.new('AO', 'vowel'),
                             Phone.new('AW', 'vowel'),
                             Phone.new('AY', 'vowel'),
                             Phone.new('B',  'stop'),
                             Phone.new('CH', 'affricate'),
                             Phone.new('D',  'stop'),
                             Phone.new('DH', 'fricative'),
                             Phone.new('EH', 'vowel'),
                             Phone.new('ER', 'vowel'),
                             Phone.new('EY', 'vowel'),
                             Phone.new('F',  'fricative'),
                             Phone.new('G',  'stop'),
                             Phone.new('HH', 'aspirate'),
                             Phone.new('IH', 'vowel'),
                             Phone.new('IY', 'vowel'),
                             Phone.new('JH', 'affricate'),
                             Phone.new('K',  'stop'),
                             Phone.new('L',  'liquid'),
                             Phone.new('M',  'nasal'),
                             Phone.new('N',  'nasal'),
                             Phone.new('NG', 'nasal'),
                             Phone.new('OW', 'vowel'),
                             Phone.new('OY', 'vowel'),
                             Phone.new('P',  'stop'),
                             Phone.new('R',  'liquid'),
                             Phone.new('S',  'fricative'),
                             Phone.new('SH', 'fricative'),
                             Phone.new('T',  'stop'),
                             Phone.new('TH', 'fricative'),
                             Phone.new('UH', 'vowel'),
                             Phone.new('UW', 'vowel'),
                             Phone.new('V',  'fricative'),
                             Phone.new('W',  'semivowel'),
                             Phone.new('Y',  'semivowel'),
                             Phone.new('Z',  'fricative'),
                             Phone.new('ZH', 'fricative')]
      end
    end

    describe '#sonority' do
      it 'returns the relative sonority of a phone' do
        Phone.new('', 'stop').sonority.should == 1
        Phone.new('', 'affricate').sonority.should == 2
        Phone.new('', 'fricative').sonority.should == 3
        Phone.new('', 'nasal').sonority.should == 4
        Phone.new('', 'liquid').sonority.should == 5
        Phone.new('', 'semivowel').sonority.should == 6
        Phone.new('', 'vowel').sonority.should == 7
      end
    end

  end
end
