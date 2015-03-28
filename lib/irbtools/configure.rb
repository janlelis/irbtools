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

    # add a callback that gets (usually) executed after loading the library
    def add_library_callback(lib, &block)
      lib = lib.to_s
      @lib_hooks[lib] << block
    end

    # replace all callbacks with the new one given in the block
    # a callback that gets (usually) executed after loading the library
    def replace_library_callback(lib, &block)
      lib = lib.to_s
      @lib_hooks[lib].clear
      @lib_hooks[lib] << block
    end

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

    # add extensions packages
    def add_package(pkg)
      @packages << pkg.to_s
    end

    # remove extension package
    def remove_package(pkg)
      @packages.delete pkg.to_s
    end

    # actually require registered packages
    def load_packages
      @packages.each{ |pkg|
        require "irbtools/#{pkg}"
      }
    end

    # te be triggered when a library has loaded
    def library_loaded(lib)
      @lib_hooks[lib.to_s].each{ |hook| hook.call }
    end

    # actually load libraries
    def load_libraries(libs)
      remember_verbose_and_debug = $VERBOSE, $DEBUG
      $VERBOSE = $DEBUG = false

      libs.each{ |lib|
        begin
          require lib.to_s
          library_loaded(lib)
        rescue Exception => err
          warn "Error while loading a library into IRB:\n\n### #{err.class}\n" +
               err.message + "\n\n### STACKTRACE\n  " + err.backtrace*"\n  " + "\n\n\n"
        end
      }
      $VERBOSE, $DEBUG = remember_verbose_and_debug
    end

    # configure irb
    def configure_irb!
      if defined?(IRB)
        IRB.conf[:AUTO_INDENT]  = true                 # simple auto indent
        IRB.conf[:EVAL_HISTORY] = 42424242424242424242 # creates the special __ variable
        IRB.conf[:SAVE_HISTORY] = 2000                 # how many lines will go to ~/.irb_history

        # prompt
        (IRB.conf[:PROMPT] ||= {} ).merge!( {:IRBTOOLS => {
          :PROMPT_I => ">> ",    # normal
          :PROMPT_N => "|  ",    # indenting
          :PROMPT_C => " > ",    # continuing a statement
          :PROMPT_S => "%l> ",   # continuing a string
          :RETURN   => "=> %s \n",
          :AUTO_INDENT => true,
        }})

        IRB.conf[:PROMPT_MODE] = :IRBTOOLS
      end
    end

    # add '.' to load path
    def add_current_directory_to_load_path!
      $LOAD_PATH << '.'
    end

    # check if we are in a RIPL session
    def ripl?
      defined?(Ripl) && Ripl.started?
    end

    # loads all the stuff
    def start
      require 'irbtools'
    end
  end
end

# # # # #
# libraries

require 'irbtools/libraries' unless Irbtools.minimal
