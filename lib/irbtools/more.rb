standalone = !(defined? Irbtools)

require_relative 'more/version'

require 'irbtools/configure'

# Better auto-completion
Irbtools.add_library :bond, :thread => 'more_2' do
  Bond.start :gems => %w[irbtools]
end

# Object#l method for inspecting its lookup path
Irbtools.add_library 'looksee', late_thread: :c do
  Looksee.rename :l
  class Object; def lp() l end; end
end

# repl method
Irbtools.add_library 'binding_of_caller', thread: 'more_3'
Irbtools.add_library 'debugging/repl', thread: 'more_3'

# new guessmethod
Irbtools.add_library 'did_you_mean', thread: 'more_4'

# load now
Irbtools.start if standalone

