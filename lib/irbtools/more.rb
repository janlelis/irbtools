standalone = !(defined? Irbtools)

require_relative 'more/version'

require 'irbtools/configure'

begin
  # Object#l method for inspecting its lookup path
  Irbtools.add_library 'looksee', thread: :more2 do
    Looksee.rename :lp
  end
rescue LoadError
  # do not load if not supported
end

# load now
Irbtools.start if standalone

