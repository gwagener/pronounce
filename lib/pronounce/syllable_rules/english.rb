module Pronounce::SyllableRules
  rule :en, '/ng/ cannot start a syllable' do
    onset cannot_match 'NG'
  end

  # http://en.wikipedia.org/wiki/Syllable_weight#Linguistics
  rule :en, 'stressed syllables cannot be light' do
    syllable cannot_be :stressed, :light
  end

  rule :en, 'doublet onsets' do
    verbatim do |context|
      if context.pending_onset.length == 2 &&
        !(context.pending_onset[1].eql?(::Pronounce::Phone.new('Y')) ||
          context.pending_onset[1].approximant? &&
            (context.pending_onset[0].articulation?(:stop) ||
              (context.pending_onset[0].articulation?(:fricative) &&
                context.pending_onset[0].voiceless?)))
        :no_new_syllable
      else
        :not_applicable
      end
    end
  end

  # /s/ may appear before a voiceless stop or fricative which may optionally be
  # followed by an approximant.
  rule :en, '/s/ cluster onsets' do
    verbatim do |context|
      if (context.pending_onset.length == 2 ||
          (context.pending_onset.length == 3 && context.pending_onset[2].approximant?)) &&
        context.pending_onset[0].eql?(::Pronounce::Phone.new('S')) &&
        context.pending_onset[1].voiceless? &&
        context.pending_onset[1].articulation?(:stop, :fricative)

        context.current_phone.eql?(context.pending_onset[0]) ? :new_syllable : :no_new_syllable
      else
        :not_applicable
      end
    end
  end

end
