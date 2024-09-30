require "irb/command"

module Irbtools
  module Command
    class Sys < IRB::Command::Base
      category "Misc"
      description 'Run a system command'
      help_message <<~HELP
        Run a command via Ruby's Kernel#system method

        Example usage: $ cowsay "Hello from IRB"
      HELP

      def execute(arg)
        system(arg)
      end
    end
  end
end

