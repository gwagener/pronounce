require 'pronounce/syllable_rules/rule_language'

module Pronounce::SyllableRules
  class Rule
    def initialize(&definition)
      @definition = definition
    end

    def evaluate(context)
      RuleResult.new(nil, RuleLanguage.run(definition, context))
    end

    private

    attr_reader :definition

  end
end
