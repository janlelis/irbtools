begin
  require 'binding_of_caller'
rescue LoadError
end

if RUBY_VERSION >= "2.5.0"
  if defined? BindingOfCaller
    module Kernel
      private def irb
        binding.of_caller(1).irb
      end
    end
  end
else
  require 'binding.repl'
  BindingRepl.auto = %w[irb ripl ir rib pry]

  class Binding
    alias irb repl!
  end

  if defined? BindingOfCaller
    require 'debugging/repl'

    module Debugging
      alias irb repl
    end
  end
end
