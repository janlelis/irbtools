require "irb"

module IRB
  module Command
    class Code < Base
      category "Introspection"
      description "Shows the syntax-highlighted source code of a method"

      class << self
        def transform_args(args)
          if args.strip =~ /\A(?:([\w:]+)([#.]))?(\w+[?!]?)\z/
            if $1
              if $2 == "#"
                "#{$1}, #{$1}.instance_method(:#{$3})"
              else
                "#{$1}, :#{$3}"
              end
            else
              ":" + $3
            end
          else
            args
          end
        end
      end

      def execute(*args)
        @irb_context.workspace.binding.send(:code, *args)
      rescue NameError
        warn "code: Class or method not found."
      end
    end
  end
end

