# check if loaded_directly to decide if Irbtools.init should be called
init_irbtools =  !(defined? Irbtools)

# define version
module Irbtools
  module More
    VERSION = ( File.read File.expand_path( '../../VERSION', File.dirname(__FILE__)) ).chomp
  end
end

# require base package
begin
  require 'irbtools/configure'
rescue LoadError
  raise "Sorry, the irbtools-more package couldn't load, because the irbtools gem is not available"
end

# irbtools extra libraries
Irbtools.add_library :drx
Irbtools.add_library :fastri
Irbtools.add_library :bond do
  Bond.start
end

# load now
Irbtools.init if init_irbtools

# J-_-L
