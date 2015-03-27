require_relative 'version'

module Irbtools
  @libraries       = { :start => [], :sub_session => [], :autoload => [], :thread => {}, :late => [], :late_thread => {} }
  @lib_hooks       = Hash.new{|h,k| h[k] = [] }
  @packages        = []
  @shell_name      = File.split($0)[-1].upcase
  @welcome_message = "Welcome to #{ @shell_name }. You are using #{ RUBY_DESCRIPTION }. Have fun ;)"
  @minimal         ||= false

  class << self
    # message to display when starting. Set to nil to disable
    attr_accessor :welcome_message

    # shell name (usually irb), retrieved from $0
    attr_reader :shell_name

    # set this to true before loading this file to deactivate loading of default libraries
    attr_accessor :minimal

    # a hash of arrays of libraries that get loaded
    # keys determine if lib is required, required on sub-session or autoloaded
    attr_accessor :libraries
    alias libs libraries
    alias libs= libraries=
    alias gems libraries
    alias gems= libraries=

    # an array of extension packages that get loaded (e.g. irbtools-more)
    attr_accessor :packages

    # add a library. the block gets executed, when the library was loaded.
    # if the second param is true, it's hooked in into IRB.conf[:IRB_RC] instead of the start.
    def add_library(lib, options = {}, &block)
      lib = lib.to_s

      if constant = options[:autoload]
        lib_path = File.split( lib ); lib_path.delete('.')
        gem_name = lib_path[0] # assume that first dir in load dir is the gem name
        if constant.is_a?(Array)
          constant.each{ |single_constant|
            @libraries[:autoload] << [single_constant, lib, gem_name]
          }
        else
          @libraries[:autoload] << [constant, lib, gem_name]
        end
      elsif options[:after_rc]
        @libraries[:after_rc] << lib
      elsif which = options[:thread]
        @libraries[:thread][which] ||= []
        @libraries[:thread][which] << lib
      elsif options[:late]
        @libraries[:late] << lib
      elsif which = options[:late_thread]
        @libraries[:late_thread][which] ||= []
        @libraries[:late_thread][which] << lib
      else
        @libraries[:start] << lib
      end

      add_library_callback(lib, &block) if block_given?
    end
    alias add_lib add_library
    alias add_gem add_library

    # add a callback that gets (usually) executed after loading the library
    def add_library_callback(lib, &block)
      lib = lib.to_s
      @lib_hooks[lib] << block
    end
    alias add_lib_callback add_library_callback
    alias add_gem_callback add_library_callback

    # replace all callbacks with the new one given in the block
    # a callback that gets (usually) executed after loading the library
    def replace_library_callback(lib, &block)
      lib = lib.to_s
      @lib_hooks[lib].clear
      @lib_hooks[lib] << block
    end
    alias replace_lib_callback replace_library_callback
    alias replace_gem_callback replace_library_callback

    # don't load a specific library
    def remove_library(lib)
      lib = lib.to_s

      @libraries[:start].delete lib
      @libraries[:sub_session].delete lib
      @libraries[:autoload].reject!{|_,e,| e == lib }
      @libraries[:thread].each{ |_,libs| libs.delete lib }
      @libraries[:late].delete lib
      @libraries[:late_thread].each{ |_,libs| libs.delete lib }

      @lib_hooks.delete lib
    end
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
require File.expand_path( 'libraries.rb', File.dirname(__FILE__) ) unless Irbtools.minimal

# J-_-L

