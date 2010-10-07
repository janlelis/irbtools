# encoding: utf-8

# # # # #
# require 'irbtools' in your .irbrc
# but you could also require 'irbtools/configure' and then call Irbtools.init to modify the loaded libraries
# see the README file for more information

begin
  require 'zucker/alias_for'
  require 'zucker/env'       # Info, OS, RubyVersion, RubyEngine
rescue LoadError
  puts "The irbtools couldn't load, because the zucker gem is not available"
else
  # suggested libraries
  module Irbtools
    @libs = ['rubygems',
       'wirble',        # colors
       'hirb',          # active record tables
       'fileutils',     # cd, pwd, ln_s, mv, rm, mkdir, touch ... ;)
       'zucker/debug',  # nice debug printing (q, o, c, .m, .d)
       'ap',            # nice debug printing (ap)
       'yaml',          # nice debug printing (y)
       'g',             # nice debug printing (g) - MacOS only :/
       'clipboard',     # easy clipboard access (copy & paste)
       'guessmethod',   # automatically correct typos (method_missing hook)
        # 'drx',           # nice tk object inspector (.see) [not included because it fails to install out of the box on lots of systems]
       'interactive_editor',  # lets you open vim (or your favourite editor), hack something, save it, and it's loaded in the current irb session
       'coderay',       # some nice colorful display ;)
       'boson',         # IRB commands repository (which also works for the shell!)
       'irb_rocket',    # put result as comment instead of a new line!
       # 'zucker/all'   # see rubyzucker.info
      ]

    if OS.windows?
      @libs -= %w[irb_rocket coderay]
    end

    unless OS.mac?
      @libs -= %w[g]
    end

    if RubyVersion.is? 1.9
      @libs -= %w[guessmethod]
    end

    class << self
      def libs
        @libs
      end
      aliases_for :libs, :gems, :libraries

      def init
        require File.expand_path( '../irbtools.rb', File.dirname(__FILE__) )
      end
    end
  end#module
end

# J-_-L
