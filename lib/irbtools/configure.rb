# encoding: utf-8

# # # # #
# require 'irbtools' in your .irbrc
# but you could also require 'irbtools/configure' and then call Irbtools.init to modify the loaded libraries
# see the README file for more information

# # # # #
# define module methods
module Irbtools
  VERSION = File.read( File.dirname(__FILE__) + '/../../VERSION' ).chomp

  @lib_hooks       = Hash.new{|h,k| h[k] = [] }
  @libraries       = { :start => [], :after_rc => [], :autoload => [], :thread => {} }
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
    attr_accessor :libraries
    # aliases_for :libs, :libraries, :gems
    # aliases_for :libs=, :libraries=, :gems=
    alias libs libraries
    alias libs= libraries=
    alias gems libraries
    alias gems= libraries=

    # an array of extension packages that get loaded (e.g. irbtools-more)
    attr_accessor :packages

    # add a library. the block gets executed, when the library was loaded.
    # if the second param is true, it's hooked in into IRB.conf[:IRB_RC] instead of the start.
    def add_library(lib, options = {}, &block)
      if constant = options[:autoload]
        lib_path = File.split( lib.to_s ); lib_path.delete('.')
        gem_name = lib_path[0] # assume that first dir in load dir is the gem name
        if constant.is_a?(Array)
          constant.each{ |single_constant|
            @libraries[:autoload] << [single_constant, lib.to_s, gem_name]
          }
        else
          @libraries[:autoload] << [constant, lib.to_s, gem_name]
        end
      elsif options[:after_rc]
        @libraries[:after_rc] << lib.to_s
      elsif which = options[:thread]
        @libraries[:thread][which] ||= []
        @libraries[:thread][which] << lib.to_s
      else
        @libraries[:start] << lib.to_s
      end

      @lib_hooks[lib.to_s] << block if block_given?
    end
    # aliases_for :add_library, :add_lib, :add_gem
    alias add_lib add_library
    alias add_gem add_library

    # don't load a specific library
    def remove_library(lib)
      @libraries[:require].delete lib.to_s
      @libraries[:after_rc].delete lib.to_s
      @libraries[:autload].reject{|_,e| e == lib.to_s }
      @lib_hooks.delete lib.to_s
    end
    # aliases_for :remove_library, :remove_lib, :remove_gem
    alias remove_lib remove_library
    alias remove_gem remove_library

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
end

# # # # #
# libraries
require File.expand_path( 'libraries.rb', File.dirname(__FILE__) )

# J-_-L

