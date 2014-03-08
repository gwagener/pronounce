module Pronounce::SyllableRules
  # Breaks syllables at the low point of sonority between vowels.
  rule :base, 'Sonority Sequencing Principle' do
    verbatim do |context|
      return :new_syllable if context.current_phone.syllabic? && !context.previous_phone_in_onset?
      return :no_new_syllable if context.word_end?
      (context.sonority_trough? ||
        (context.previous_phone < context.current_phone &&
          context.previous_phone_in_coda?)) ? :new_syllable : :no_new_syllable
    end
  end

end
