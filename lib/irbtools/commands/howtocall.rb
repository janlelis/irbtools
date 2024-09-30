require "irb/command"

module Irbtools
  module Command
    class Howtocall < IRB::Command::Base
      category "Introspection"
      description "Displays method signatures based on Method#parameters"
      help_message <<~HELP
        Displays method signatures based on Method#parameters, with the same limitations,
        so it's more useful with methods implemented in Ruby itself

        Example usages:
        >> howtocall Gem.add_to_load_path
        >> howtocall Array#sum
      HELP

      def transform_arg(arg)
        if arg.empty?
          "[]"
        elsif arg.strip =~ /\A(?:([\w:]+)([#.]))?(\w+[?!]?)\z/
          if $1
            if $2 == "#"
              "[#{$1}, #{$1}.instance_method(:#{$3})]"
            else
              "[#{$1}, :#{$3}]"
            end
          else
            "[:#{$3}]"
          end
        else
          nil
        end
      end

      def execute(arg)
        if howtocall_parameters_code = transform_arg(arg)
          howtocall_parameters = @irb_context.workspace.binding.eval(howtocall_parameters_code)
          @irb_context.workspace.binding.send(:howtocall, *howtocall_parameters)
        else
          warn "howtocall: Please use rdoc syntax, e.g. Array#sum"
        end
      rescue NameError
        warn "howtocall: Class or method not found"
      end
    end
  end
end

