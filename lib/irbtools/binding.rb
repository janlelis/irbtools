begin
  require 'binding_of_caller'
rescue LoadError
end

if defined? BindingOfCaller
  module Kernel
    private def irb
      binding.of_caller(1).irb
    end
  end
end
