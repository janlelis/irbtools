# require this file (instead of configure) to deactivate loading of default set of libraries

module Irbtools
  @minimal = true
end

require 'irbtools/configure'
