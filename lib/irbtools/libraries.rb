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

Irbtools.add_library 'instance', thread: 30

Irbtools.add_library 'ori', thread: 50 do
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

Irbtools.add_library 'method_locator', thread: 60 do
  module MethodLocator
    alias mlp method_lookup_path
  end
end


# # # load via autoload

Irbtools.add_library 'ruby_info', :autoload => :RubyInfo do
  def info() RubyInfo  end unless defined? info
end

Irbtools.add_library 'os', :autoload => :OS do
  def os() OS          end unless defined? os
end

Irbtools.add_library 'ruby_engine', :autoload => :RubyEngine do
  def engine() RubyEngine  end unless defined? engine
end

Irbtools.add_library 'ruby_version', :autoload => :RubyVersion do
  def version() RubyVersion end unless defined? version
end

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
