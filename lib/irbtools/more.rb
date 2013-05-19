# check if loaded_directly to decide if Irbtools.init should be called
standalone =  !(defined? Irbtools)

# define version
module Irbtools
  module More
    VERSION = '1.5.0'
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

# Object#l method for inspecting its load path
Irbtools.add_library 'looksee', :late_thread => :c do
  Looksee::ObjectMixin.rename :ls => :l
  class Object; alias ll l end
end

# load now
if standalone
  Irbtools.start
end

# J-_-L
