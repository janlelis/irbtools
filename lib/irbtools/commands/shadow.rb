require "irb/command"

module Irbtools
  module Command
    class Shadow < IRB::Command::Base
      category "Introspection"
      description 'Method list and lookup path inspection based on the object shadow gem'
      help_message <<~HELP
        Method list and lookup path inspection based on the object shadow gem.

        Example usage: + [1,2,3]
      HELP

      def execute(arg)
        if arg.strip.empty?
          p @irb_context.workspace.binding.shadow
        else
          p @irb_context.workspace.binding.eval(arg).shadow
        end
      end
    end
  end
end

