require "irb"

module IRB
  module Command
    class Shadow < Base
      category "Introspection"
      description 'Method list and lookup path inspection based on object shadow gem'

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

