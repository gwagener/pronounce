require 'forwardable'

module Pronounce::SyllableRules
  class RuleSet
    extend Forwardable

    def_delegators :rules, :[]

    def initialize
      @rules = {}
    end

    def add(path, rule)
      name, *nested_path = path
      if nested_path.any?
        rules[name] = RuleSet.new unless rules.has_key? name
        rules[name].add nested_path, rule
      else
        rules[name] = rule
      end
    end

    def evaluate(context)
      base_rules = -> { rules[:base] ? rules[:base].evaluate(context) : :not_applicable }
      rules.reject {|key, _| key == :base }.
        map {|_, rule| rule.evaluate context }.
        find(base_rules) {|result| result != :not_applicable }
    end

    private

    attr_reader :rules

  end
end
