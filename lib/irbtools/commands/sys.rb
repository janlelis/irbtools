require "irb/cmd/nop"

module IRB
  module ExtendCommand
    class Sys < Nop
      category "Misc"
      description 'Run a system command'

      class << self
        def transform_args(args)
          if args.empty? || string_literal?(args)
            args
          else
            args.strip.dump
          end
        end
      end

      def execute(*args)
        system(*args)
      end
    end
  end
end

