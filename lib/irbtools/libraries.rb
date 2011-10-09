# encoding: utf-8
# default irbtools set of libraries, you can remove any you don't like via Irbtools.remove_library

require 'rbconfig'

# # # load on startup

Irbtools.add_library :yaml


# # # load via late

unless defined?(Ripl) && Ripl.respond_to?(:started?) && Ripl.started?
  # terminal colors
  Irbtools.add_library :paint, :late => true

  # use hash rocket and colorful errors/streams
  Irbtools.add_library :fancy_irb, :late => true do
    FancyIrb.start
  end
end


# # # load via late_thread

# result colors, install ripl-color_result for ripl colorization
Irbtools.add_library :wirb, :late_thread => 10 do 
  Wirb.load_schema :classic_paint
  Wirb.start
end

Irbtools.add_library 'wirb/wp',  :late_thread => 10 # ap alternative (wp)

Irbtools.add_library 'paint/pa', :late_thread => 20 # colorize a string (pa)


# # # load via thread
#      the :stdlib thread ensures proper loading of fileutils and tempfile

Irbtools.add_library :fileutils, :thread => :stdlib do # cd, pwd, ln_s, mv, rm, mkdir, touch ... ;)
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

# tables, menus...
Irbtools.add_library :hirb, :late_thread => :stdlib do
  Hirb::View.enable
  extend Hirb::Console
  Hirb::View.formatter.add_view 'Object', :ancestor => true, :options => { :unicode => true } # unicode tables

  #colorful
  table_color = Wirb.schema[:class]
  Hirb::Helpers::Table::CHARS.each do |place, group|
    Hirb::Helpers::Table::CHARS[place] = 
    group.each do |name, part|
      if part.kind_of? String
        Hirb::Helpers::Table::CHARS[place][name] = Paint[part, *table_color]
      elsif part.kind_of? Hash
        part.each do |special, char|
          Hirb::Helpers::Table::CHARS[place][name][special] = Paint[char, *table_color]
        end
      end
    end
  end

end

# command framework
Irbtools.add_library :boson, :late_thread => :stdlib do
  # hirb issues, TODO fix cleanly
  undef install if respond_to?( :install, true )
  Hirb::Console.class_eval do undef menu end if respond_to?( :menu, true )
  Boson.start :verbose => false
end

# ls, cat, rq, rrq, ld, session_history, reset!, clear, dbg, ...
Irbtools.add_library 'every_day_irb', :thread => 10 

# nice debug printing (q, o, c, .m, .d)
Irbtools.add_library 'zucker/debug', :thread => 20

# nice debug printing (ap)
Irbtools.add_library 'ap', :thread => 30

# nice debug printing (g)
Irbtools.add_library 'g', :thread => 40 if RbConfig::CONFIG['host_os'] =~ /mac|darwin/

# lets you open vim (or your favourite editor), hack something, save it, and it's loaded in the current irb session
Irbtools.add_library 'interactive_editor', :thread => :stdlib

# another, more flexible "start editor and it gets loaded into your irb session" plugin
Irbtools.add_library 'sketches', :thread => :stdlib    

# object oriented ri method
Irbtools.add_library :ori, :thread => 50 do
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

# useful information pseudo-constants
Irbtools.add_library 'zucker/env', :autoload => [:RubyVersion, :RubyEngine, :Info, :OS] do
  def rv() RubyVersion end unless defined? rv
  def re() RubyEngine  end unless defined? re
end

# syntax highlight
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

# access the clipboard
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
  alias copy_session_input copy_input

  # copies the output of all irb commands in this irb session
  def copy_output
    copy context.instance_variable_get(:@eval_history_values).inspect.gsub(/^\d+ (.*)/, '\1')
    "The session output history has been copied to the clipboard."
  end
  alias copy_session_output copy_output
end

# small-talk like method finder
Irbtools.add_library :methodfinder, :autoload => :MethodFinder do
  MethodFinder::INSTANCE_METHOD_BLACKLIST[:Object] += [:ri, :vi, :vim, :emacs, :nano, :mate, :mvim, :ed, :sketch]
  
  def mf(*args, &block)
    args.empty? ? MethodFinder : MethodFinder.find(*args, &block)
  end
end

# rvm helpers
Irbtools.add_library 'rvm_loader', :autoload => :RVM do
  def rubies
    RVM.current.list_strings
  end

  def use(which = nil) # TODO with gemsets?
    # show current ruby if called without options
    if !which
      return RVM.current.environment_name[/^.*@|.*$/].chomp('@')
    end

    # start ruby :)
    begin
      RVM.use! which.to_s
    rescue RVM::IncompatibleRubyError => err
      err.message =~ /requires (.*?) \(/
      rubies = RVM.current.list_strings
      if rubies.include? $1
        # remember history...
        run_irb = proc{ exec "#{ $1 } -S #{ $0 }" } 
        if defined?(Ripl) && Ripl.respond_to?(:started?) && Ripl.started?
          Ripl.shell.write_history if Ripl.shell.respond_to? :write_history
          run_irb.call
        else
          at_exit(&run_irb)
          exit
        end
      else
        warn "Sorry, that Ruby version could not be found (see rubies)!"
      end
    end
  end
  alias use_ruby use

  def gemsets
    RVM.current.gemset.list
  end

  def gemset(which = nil)
    if which
      if RVM.current.gemset.list.include? which.to_s
        RVM.use! RVM.current.environment_name.gsub(/(@.*?$)|$/, "@#{ which }")
      else
        warn "Sorry, that gemset could not be found (see gemsets)!"
      end
    end
    RVM.current.gemset_name
  end
  alias use_gemset gemset
end

# J-_-L
