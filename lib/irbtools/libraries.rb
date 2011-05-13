# encoding: utf-8

# default irbtools set of libraries, you can remove any you don't like via Irbtools.remove_library

# # # load via threads

Irbtools.add_library :wirb, :thread => 10 do # result colors, install ripl-color_result for ripl colorization
  Wirb.start unless OS.windows?
end unless OS.windows? || ( defined?(Ripl) ) #&& Ripl.started? )

Irbtools.add_library :fancy_irb, :thread => 20 do # put result as comment instead of a new line and colorful errors/streams
  FancyIrb.start
end unless defined?(Ripl) # && Ripl.started?

Irbtools.add_library :hirb, :thread => 30 do
  Hirb::View.enable
  extend Hirb::Console
  Hirb::View.formatter.add_view 'Object', :ancestor => true, :options => { :unicode => true } # unicode tables
end

Irbtools.add_library :boson, :thread => 30 do
  undef install if respond_to?( :install, true )
  undef menu    if respond_to?( :menu, true )
  Boson.start :verbose => false
end

Irbtools.add_library :fileutils, :thread => 40 do # cd, pwd, ln_s, mv, rm, mkdir, touch ... ;)
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
    cd path
    @last_path = new_last_path
    ls
  end
end

Irbtools.add_library 'zucker/debug', :thread => 50 # nice debug printing (q, o, c, .m, .d)

Irbtools.add_library 'ap', :thread => 60           # nice debug printing (ap)

Irbtools.add_library 'wirb/wp', :thread => 70      # ap alternative (wp)

Irbtools.add_library 'g', :thread => 80 if OS.mac? # nice debug printing (g) - MacOS only :/

Irbtools.add_library 'interactive_editor', :thread => 90  # lets you open vim (or your favourite editor), hack something, save it, and it's loaded in the current irb session

Irbtools.add_library 'sketches', :thread => 100    # another, more flexible "start editor and it gets loaded into your irb session" plugin

Irbtools.add_library :ori, :thread => 110 do       # object oriented ri method
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


# # # load via autoload

Irbtools.add_library :coderay, :autoload => :CodeRay do
  # syntax highlight a string
  def colorize(string)
    puts CodeRay.scan( string, :ruby ).term
  end

  # syntax highlight a file
  def ray(path)
    print CodeRay.scan( File.read(path), :ruby ).term
  end
end unless OS.windows?

Irbtools.add_library :clipboard, :autoload => :Clipboard do # access the clipboard
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

Irbtools.add_library :methodfinder, :autoload => :MethodFinder do # small-talk like method finder
  MethodFinder::INSTANCE_METHOD_BLACKLIST[:Object] += [:ri, :vi, :vim, :emacs, :nano, :mate, :mvim, :ed, :sketch]
  
  def mf(*args, &block)
    args.empty? ? MethodFinder : MethodFinder.find(*args, &block)
  end
end

# J-_-L
