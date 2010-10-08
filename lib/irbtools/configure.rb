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
  @railsrc = '~/.railsrc'

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

    def railsrc
      @railsrc
    end

    def railsrc=(path)
      @railsrc = path
    end

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
require File.expand_path( 'libraries.rb', File.dirname(__FILE__) )

# J-_-L

