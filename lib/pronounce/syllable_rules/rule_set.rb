require 'forwardable'
require 'pronounce/syllable_rules/rule_set_result'

module Pronounce::SyllableRules
  class RuleSet
    extend Forwardable

    def_delegators :rules, :[], :delete

    def initialize(name)
      @set_name = name
      @rules = {}
    end

    def add(path, rule)
      name, *nested_path = path
      if nested_path.any?
        ensure_rule_set_exists(name)
        rules[name].add(nested_path, rule)
      else
        rules[name] = rule
      end
    end

    def evaluate(context)
      RuleSetResult.new(set_name, rule_results(context).max.value)
    end

    private

    attr_reader :rules, :set_name

    def ensure_rule_set_exists(name)
      rules[name] = RuleSet.new(name) unless rules.has_key? name
    end

    def rule_results(context)
      rules.values.map { |rule| rule.evaluate(context) }
    end

  end
end
