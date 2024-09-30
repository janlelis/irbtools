require "irb/command"

module Irbtools
  module Command
    class Look < IRB::Command::Base
      category "Introspection"
      description 'Method list and lookup path inspection based on the looksee gem'
      help_message <<~HELP
        Method list and lookup path inspection based on the looksee gem.

        Example usage: look [1,2,3]
      HELP

      def execute(arg)
        if arg.strip.empty?
          p @irb_context.workspace.binding.look
        else
          p @irb_context.workspace.binding.eval(arg).look
        end
      end
    end
  end
end
