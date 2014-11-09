# check if loaded_directly to decide if Irbtools.init should be called
standalone = !(defined? Irbtools)

# define version
module Irbtools
  module More
    VERSION = '1.7.1'
  end
end

# require base package
if standalone
  begin
    require 'irbtools/configure'
  rescue LoadError
    raise "Sorry, the irbtools-more package couldn't load, because the irbtools gem is not available"
  end
end

# # # libraries

# Better auto-completion
Irbtools.add_library :bond, :thread => 'more_2' do
  Bond.start :gems => %w[irbtools]
end

# Object#l method for inspecting its lookup path
Irbtools.add_library 'looksee', late_thread: :c do
  Looksee::ObjectMixin.rename :l
  class Object; alias lp l; end
end

# repl method
Irbtools.add_library 'binding_of_caller', thread: 'more_3'
Irbtools.add_library 'debugging/repl', thread: 'more_3'

# new guessmethod
Irbtools.add_library 'did_you_mean', thread: 'more_4'

# load now
Irbtools.start if standalone

# J-_-L
