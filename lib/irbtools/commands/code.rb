require "irb/command"

module Irbtools
  module Command
    class Code < IRB::Command::Base
      category "Introspection"
      description "Shows the syntax-highlighted source code of a method"
      help_message <<~HELP
        Shows the syntax-highlighted source code of a method. Works with Ruby's
        native methods.

        Example usages:
        >> code SecureRandom.uuid
        >> code Array#reverse
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
        if code_parameters_code = transform_arg(arg)
          code_parameters = @irb_context.workspace.binding.eval(code_parameters_code)
          @irb_context.workspace.binding.send(:code, *code_parameters)
        else
          warn "code: Please use rdoc syntax, e.g. Array#sum"
        end
      rescue NameError
        warn "code: Class or method not found."
      end
    end
  end
end

