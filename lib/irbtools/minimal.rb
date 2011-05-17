# require this file (instead of configure) to deactivate loading of default set of libraries

module Irbtools
  @minimal = true
end

require File.expand_path( 'configure.rb', File.dirname(__FILE__) ) 

# J-_-L
