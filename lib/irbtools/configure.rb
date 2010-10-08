# encoding: utf-8

# # # # #
# require 'irbtools' in your .irbrc
# but you could also require 'irbtools/configure' and then call Irbtools.init to modify the loaded libraries
# see the README file for more information

begin
  require 'zucker/alias_for'
  require 'zucker/env'       # Info, OS, RubyVersion, RubyEngine
rescue LoadError
  raise "Sorry, the irbtools couldn't load, because the zucker gem is not available"
end

# # # # #
# define module methods
module Irbtools
  @lib_hooks = Hash.new{|h,k| h[k] = [] }
  @libs = %w[rubygems]

  class << self
    def libraries
      @libs
    end
    aliases_for :libraries, :gems, :libs

    def libraries=(value)
      @libs = value
    end
    aliases_for :'libraries=', :'gems=', :'libs='

    def add_library(lib, &block)
      @libs << lib.to_s unless @libs.include? lib.to_s
      @lib_hooks[lib.to_s] << block if block_given?
    end
    aliases_for :add_library, :add_lib, :add_gem

    def remove_library(lib)
      @libs.delete lib.to_s
      @lib_hooks.delete lib.to_s
    end
    aliases_for :remove_library, :remove_lib, :remove_gem

    def library_loaded(lib)
      @lib_hooks[lib.to_s].each{ |hook| hook.call }
    end
    private :library_loaded

    def init
      require File.expand_path( '../irbtools.rb', File.dirname(__FILE__) )
    end
    alias start init
  end

  VERSION = File.read File.expand_path( '../../VERSION', File.dirname(__FILE__) )
end

# # # # #
# libraries
Irbtools.add_library :wirble do # colors
  Wirble.init
  Wirble.colorize unless OS.windows?
end

Irbtools.add_library :hirb do # active record tables
  Hirb::View.enable
end

Irbtools.add_library :fileutils do # cd, pwd, ln_s, mv, rm, mkdir, touch ... ;)
  include FileUtils::Verbose
end

Irbtools.add_library :coderay do
  # syntax highlight a string
  def colorize(string)
    puts CodeRay.scan( string, :ruby ).term
  end

  # syntax highlight a file
  def ray(path)
    puts CodeRay.scan( File.read(path), :ruby ).term
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
Irbtools.add_library 'guessmethod'  # automatically correct typos (method_missing hook)
Irbtools.add_library 'interactive_editor'  # lets you open vim (or your favourite editor), hack something, save it, and it's loaded in the current irb session
Irbtools.add_library 'irb_rocket'   # put result as comment instead of a new line!
#Irbtools.add_library 'zucker/all'   # see rubyzucker.info

if OS.windows?
  Irbtools.libraries -= %w[irb_rocket coderay]
end

unless OS.mac?
  Irbtools.libraries -= %w[g]
end

if RubyVersion.is? 1.9
  Irbtools.libraries -= %w[guessmethod]
end

# J-_-L

