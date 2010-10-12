# check if loaded_directly to decide if Irbtools.init should be called
standalone =  !(defined? Irbtools)

# define version
module Irbtools
  module More
    PACKAGE_VERSION = ( File.read File.expand_path( '../../VERSION', File.dirname(__FILE__)) ).chomp
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

# irbtools-more libraries
Irbtools.add_library :drx
Irbtools.add_library :bond do
  Bond.start
end

# load now
if standalone
  Irbtools.init
end

# J-_-L
