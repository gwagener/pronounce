require 'pronounce/syllable_rules/verbatim_definition'

module Pronounce::SyllableRules
  class RuleEvaluation
    class << self
      def result_for(definition, context)
        new(context).instance_eval(&definition)
      end

      private :new
    end

    def initialize(context)
      @context = context
    end

    ## DSL #############

    def verbatim(&block)
      VerbatimDefinition.new(block).evaluate(context)
    end

    #### subjects ######

    def onset(predicate)
      return :not_applicable if context.pending_onset == []
      predicate.call(context.pending_onset)
    end

    def syllable(predicate)
      predicate.call(context.pending_syllable)
    end

    #### predicates ####

    def cannot_be(*objects)
      lambda {|subject|
        if objects.all? {|interogative| subject.send("#{interogative}?") }
          :no_new_syllable
        else
          :not_applicable
        end
      }
    end

    def cannot_match(object)
      lambda {|subject|
        if subject.eql? [Pronounce::Phone.new(object)]
          :no_new_syllable
        else
          :not_applicable
        end
      }
    end

    ## end DSL #########

    private

    attr_reader :context

  end
end
