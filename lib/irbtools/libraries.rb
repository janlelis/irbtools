require 'rbconfig'


# # # load on startup

Irbtools.add_library 'yaml'


# # # load via thread

Irbtools.add_library 'every_day_irb', thread: :stdlib do
  include FileUtils::Verbose
  extend EveryDayIrb
end

Irbtools.add_library 'interactive_editor',  thread: :stdlib

Irbtools.add_library 'paint/pa', thread: :paint

Irbtools.add_library 'wirb/wp', thread: :paint do
  Wirb.start
end

unless Irbtools.ripl?
  Irbtools.add_library :fancy_irb, thread: :paint do
    FancyIrb.start
  end
end

Irbtools.add_library 'debugging/q',         thread: :paint
Irbtools.add_library 'debugging/mof',       thread: :paint
Irbtools.add_library 'debugging/re',        thread: :paint
Irbtools.add_library 'debugging/beep',      thread: :paint
Irbtools.add_library 'debugging/howtocall', thread: :paint

require_relative 'hirb'

Irbtools.add_library 'object_shadow', thread: :paint do
  ObjectShadow.include(ObjectShadow::DeepInspect)
end

Readline = Reline if defined? Reline
Irbtools.add_library 'ori', thread: :ori do
  # TODO Readline history can be empty (issue)
  module ORI::Internals
    def self.get_ri_arg_prefix(cmd)
      if cmd && (mat = cmd.match /\A(\s*.+?\.ri)\s+\S/)
        mat[1]
      end
    end
  end

  class Object
    # patch ori to also allow shell-like "Array#slice" syntax
    def ri(*args)
      if  args[0] &&
          self == TOPLEVEL_BINDING.eval('self') &&
          args[0] =~ /\A(.*)(?:#|\.)(.*)\Z/
        begin
          klass = Object.const_get $1
          klass.ri $2
        rescue
          super
        end
      else
        super
      end
    end
  end
end

Irbtools.add_library 'ruby_info', thread: :ri
Irbtools.add_library 'os', thread: :os
Irbtools.add_library 'ruby_engine', thread: :re
Irbtools.add_library 'ruby_version', thread: :rv

# # # load via autoload

Irbtools.add_library 'code', :autoload => :Code do
  def code(object = self, method_name)
    Code.for(object, method_name)
  end
end

Irbtools.add_library :coderay, :autoload => :CodeRay do
  # ...a string
  def colorize(string)
    puts CodeRay.scan( string, :ruby ).term
  end

  # ...a file
  def ray(path)
    print CodeRay.scan( File.read(path), :ruby ).term
  end
end

Irbtools.add_library :clipboard, :autoload => :Clipboard do
  # copies the clipboard
  def copy(str)
    Clipboard.copy(str)
  end

  # pastes the clipboard
  def paste
    Clipboard.paste
  end

  # copies everything you have entered in this irb session
  def copy_input
    copy session_history
    "The session input history has been copied to the clipboard."
  end

  # copies the output of all irb commands in this irb session
  def copy_output
    copy context.instance_variable_get(:@eval_history_values).inspect.gsub(/^\d+ (.*)/, '\1')
    "The session output history has been copied to the clipboard."
  end
end

Irbtools.add_library :methodfinder, autoload: :MethodFinder do
  MethodFinder::INSTANCE_METHOD_BLACKLIST[:Object] += [:ri, :vi, :vim, :emacs, :nano, :mate, :mvim, :ed]

  def mf(*args, &block)
    args.empty? ? MethodFinder : MethodFinder.find(*args, &block)
  end
end
