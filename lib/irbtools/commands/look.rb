require "irb"

module IRB
  module Command
    class Look < Base
      category "Introspection"
      description 'Method list and lookup path inspection based on looksee gem'

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

