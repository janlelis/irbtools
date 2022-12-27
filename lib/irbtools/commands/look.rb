require "irb/cmd/nop"

module IRB
  module ExtendCommand
    class Look < Nop
      category "Introspection"
      description 'Method list & lookup path inspection based on looksee gem'

      def execute(*args)
        if args.empty?
          @irb_context.workspace.binding.look
        else
          obj, *params = *args
          obj.look(*params)
        end
      end
    end
  end
end

