require "irb/cmd/nop"

module IRB
  module ExtendCommand
    class Shadow < Nop
      category "Introspection"
      description 'Method list & lookup path inspection based on object shadow gem'

      def execute(*args)
        if args.empty?
          @irb_context.workspace.binding.shadow
        else
          obj, *params = *args
          obj.shadow(*params)
        end
      end
    end
  end
end

