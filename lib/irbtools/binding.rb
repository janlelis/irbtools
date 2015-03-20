require 'binding.repl'
BindingRepl.auto = %w[irb ripl ir rib pry]

class Binding
  alias irb repl!
end

begin
  require 'binding_of_caller'
rescue LoadError
end

if defined? BindingOfCaller
  require 'debugging/repl'

  module Debugging
    alias irb repl
  end
end
