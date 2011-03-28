# encoding: utf-8

# # # # #
# require 'irbtools' in your .irbrc
# but you could also require 'irbtools/configure' and then call Irbtools.init to modify the loaded libraries
# see the README file for more information

# the order does matter
Irbtools.add_library :wirb do # result colors
  Wirb.start unless OS.windows?
end
Irbtools.add_library 'wirb/wp' # ap alternative


Irbtools.add_library :fancy_irb do # put result as comment instead of a new line and colorful errors/streams
  FancyIrb.start
end

Irbtools.add_library :fileutils do # cd, pwd, ln_s, mv, rm, mkdir, touch ... ;)
  include FileUtils::Verbose

  # patch cd so that it also shows the current directory
  def cd( path = File.expand_path('~') )
    new_last_path = FileUtils.pwd
    if path == '-'
      if @last_path
        path = @last_path
      else
        warn 'Sorry, there is no previous directory.'
        return
      end
    end
    FileUtils.cd path
    @last_path = new_last_path
    ls
  end

end

Irbtools.add_library :coderay do
  # syntax highlight a string
  def colorize(string)
    puts CodeRay.scan( string, :ruby ).term
  end

  # syntax highlight a file
  def ray(path)
    print CodeRay.scan( File.read(path), :ruby ).term
  end
end

Irbtools.add_library :clipboard do # access the clipboard
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
  alias copy_session_input copy_input

  # copies the output of all irb commands in this irb session
  def copy_output
    copy context.instance_variable_get(:@eval_history_values).inspect.gsub(/^\d+ (.*)/, '\1')
    "The session output history has been copied to the clipboard."
  end
  alias copy_session_output copy_output
end

Irbtools.add_library 'zucker/debug' # nice debug printing (q, o, c, .m, .d)
Irbtools.add_library 'ap'           # nice debug printing (ap)
Irbtools.add_library 'yaml'         # nice debug printing (y)
Irbtools.add_library 'g'            # nice debug printing (g) - MacOS only :/
#Irbtools.add_library 'guessmethod', true   # automatically correct typos (method_missing hook)
Irbtools.add_library 'interactive_editor'  # lets you open vim (or your favourite editor), hack something, save it, and it's loaded in the current irb session
Irbtools.add_library 'sketches'            # another, more flexible "start editor and it gets loaded into your irb session" plugin

Irbtools.add_library :boson do
  undef :install if respond_to?( :install, true )
  Boson.start :verbose => false
end

Irbtools.add_library :hirb do
  Hirb::View.enable
  extend Hirb::Console
  Hirb::View.formatter.add_view 'Object', :ancestor => true, :options => { :unicode => true } # unicode tables
end

Irbtools.add_library :ori do
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


# remove failing/not needed libs
if OS.windows?
  Irbtools.libraries -= %w[coderay]
end

unless OS.mac?
  Irbtools.libraries -= %w[g]
end

#if RubyVersion.is? 1.9
#  Irbtools.libraries_in_proc -= %w[guessmethod]
#end

if defined? Ripl
  Irbtools.libraries -= %w[wirb fancy_irb] # install ripl-color_result for ripl colorization ;)
end

# J-_-L
