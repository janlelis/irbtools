standalone = !(defined? Irbtools)

require_relative 'more/version'

require 'irbtools/configure'

warn "irbtools-more is not necessary anymore, everything has been moved to irbtools (or removed)"

# load now
Irbtools.start if standalone

