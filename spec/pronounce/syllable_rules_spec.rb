require 'pronounce/syllable_rules'

module Pronounce
  describe SyllableRules do
    describe 'rule declaration' do
      let(:rule_name) { 'name' }
      let(:set_name) { :set }

      it 'takes a name and a block' do
        result = :new_syllable
        SyllableRules.rule(rule_name) { result }
        expect(SyllableRules[rule_name].evaluate(nil).value).to eq result

        SyllableRules.delete(rule_name)
      end

      it 'can take an arbitrary length path' do
        result = :new_syllable
        SyllableRules.rule(set_name, rule_name) { result }
        expect(SyllableRules[set_name][rule_name].evaluate(nil).value).to eq result

        SyllableRules.delete(set_name)
      end
    end

  end
end
