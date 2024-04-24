require "irb"

module IRB
  module Command
    class Howtocall < Base
      category "Introspection"
      description "Displays method signatures based on Method#parameters"

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
        @irb_context.workspace.binding.send(:howtocall, *args)
      rescue NameError
        warn "howtocall: Class or method not found"
      end
    end
  end
end

