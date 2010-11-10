# encoding: utf-8

# # # # #
# require 'irbtools' in your .irbrc
# but you could also require 'irbtools/configure' and then call Irbtools.init to modify the loaded libraries
# see the README file for more information

# the order does matter
Irbtools.add_library :wirble do # colors
  Wirble.init
  Wirble.colorize unless OS.windows?
end

Irbtools.add_library :fancy_irb do # put result as comment instead of a new line!
  FancyIrb.start
end

Irbtools.add_library :fileutils do # cd, pwd, ln_s, mv, rm, mkdir, touch ... ;)
  include FileUtils::Verbose

  # patch cd so that it also shows the current directory
  def cd(path = '/', *args)
    FileUtils::Verbose.cd path, *args
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
Irbtools.add_library 'guessmethod', true   # automatically correct typos (method_missing hook)
Irbtools.add_library 'interactive_editor'  # lets you open vim (or your favourite editor), hack something, save it, and it's loaded in the current irb session
Irbtools.add_library 'sketches'            # another, more flexible "start editor and it gets loaded into your irb session" plugin
#Irbtools.add_library 'zucker/all'         # see rubyzucker.info

Irbtools.add_library :boson do
  undef :install if respond_to?( :install, true )
  Boson.start :verbose => false
end

Irbtools.add_library :hirb do # active record tables
  Hirb::View.enable
  extend Hirb::Console
end


# remove failing/not needed libs
if OS.windows?
  Irbtools.libraries -= %w[coderay]
end

unless OS.mac?
  Irbtools.libraries -= %w[g]
end

if RubyVersion.is? 1.9
  Irbtools.libraries_in_proc -= %w[guessmethod]
end

# J-_-L
