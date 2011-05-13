# encoding: utf-8

# # # # #
# require 'irbtools' in your .irbrc
# but you could also require 'irbtools/configure' and then call Irbtools.init to modify the loaded libraries
# see the README file for more information

begin
  require 'zucker/alias_for'
  require 'zucker/env'       # Info, OS, RubyVersion, RubyEngine
rescue LoadError
  raise LoadError, "Sorry, the irbtools couldn't load, because the zucker gem is not available"
end

# # # # #
# define module methods
module Irbtools
  @lib_hooks       = Hash.new{|h,k| h[k] = [] }
  @libs            = { :start => [], :after_rc => [], :autoload => [], :thread => {} }
  @packages        = []
  @railsrc         = '~/.railsrc'
  @shell_name      = File.split($0)[-1].upcase
  @welcome_message = "Welcome to #{ @shell_name }. You are using #{ RUBY_DESCRIPTION }. Have fun ;)"

  class << self
    # message to display when starting. Set to nil to disable
    attr_accessor :welcome_message

    # shell name (usually irb), retrieved from $0
    attr_reader :shell_name

    # lets you define the path to the railsrc file or deactivate this feature with nil
    attr_accessor :railsrc

    # a hash of arrays of libraries that get loaded
    # keys determine if lib is required, required on sub-session or autoloaded
    attr_accessor :libs
    aliases_for :libs, :libraries, :gems
    aliases_for :libs=, :libraries=, :gems=

    # an array of extension packages that get loaded (e.g. irbtools-more)
    attr_accessor :packages

    # add a library. the block gets executed, when the library was loaded.
    # if the second param is true, it's hooked in into IRB.conf[:IRB_RC] instead of the start.
    def add_library(lib, options = {}, &block)
      if constant = options[:autoload]
        @libs[:autoload] << [constant, lib.to_s]
      elsif options[:after_rc]
        @libs[:after_rc] << lib.to_s
      elsif which = options[:thread]
        @libs[:thread][which] ||= []
        @libs[:thread][which] << lib.to_s
      else
        @libs[:start] << lib.to_s
      end

      @lib_hooks[lib.to_s] << block if block_given?
    end
    aliases_for :add_library, :add_lib, :add_gem

    # don't load a specific library
    def remove_library(lib)
      @libs[:require].delete lib.to_s
      @libs[:after_rc].delete lib.to_s
      @libs[:autload].reject{|_,e| e == lib.to_s }
      @lib_hooks.delete lib.to_s
    end
    aliases_for :remove_library, :remove_lib, :remove_gem

    # add extensions packages
    def add_package(pkg)
      @packages << pkg.to_s
    end

    # remove extension package
    def remove_package(pkg)
      @packages.delete pkg.to_s
    end

    def library_loaded(lib) #:nodoc:
      @lib_hooks[lib.to_s].each{ |hook| hook.call }
    end
    private :library_loaded

    # loads all the stuff ;)
    def init
      require File.expand_path( '../irbtools.rb', File.dirname(__FILE__) )
    end
    alias start init
  end

  VERSION = ( File.read File.expand_path( '../../VERSION', File.dirname(__FILE__)) ).chomp
end

# # # # #
# libraries
require File.expand_path( 'libraries.rb', File.dirname(__FILE__) )

# J-_-L

