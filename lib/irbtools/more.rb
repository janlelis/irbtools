standalone = !(defined? Irbtools)

require_relative 'more/version'

require 'irbtools/configure'

# Better auto-completion
Irbtools.add_library :bond, thread: :more1 do
  Bond.start :gems => %w[irbtools]
end

# Object#l method for inspecting its lookup path
# Irbtools.add_library 'looksee', thread: :more2 do
#   Looksee.rename :lp
# end

# new guessmethod
Irbtools.add_library 'did_you_mean', thread: :more3

# load now
Irbtools.start if standalone

