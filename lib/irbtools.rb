# encoding: utf-8

# # # # #
# require 'irbtools' in your .irbrc
# see the README file for more information
require File.expand_path('irbtools/configure', File.dirname(__FILE__) ) unless defined? Irbtools

# # # # #
# load extension packages
Irbtools.packages.each{ |pkg|
  begin
    require "irbtools/#{pkg}"

  rescue LoadError => err
    warn "Couldn't load an extension package: #{err}"
  end
}

# # # # #
# load libraries

# load helper proc
load_libraries_proc = proc{ |libs|
  remember_verbose_and_debug = $VERBOSE, $DEBUG
  $VERBOSE = $DEBUG = false

  libs.each{ |lib|
    begin
      require lib.to_s

      Irbtools.send :library_loaded, lib

    rescue LoadError => err
      if err.to_s =~ /irb_rocket/ && RubyEngine.mri?
        warn "Couldn't load the irb_rocket gem.
You can install it with: gem install irb_rocket --source http://merbi.st"
      else
        warn "Couldn't load an irb library: #{err}"
      end
    end
  }
  $VERBOSE, $DEBUG = remember_verbose_and_debug
}

# load them :)
load_libraries_proc[ Irbtools.libraries ]

# load these each time a new sub irb starts
original_irbrc_proc = IRB.conf[:IRB_RC]
IRB.conf[:IRB_RC] = proc{
  load_libraries_proc[ Irbtools.libraries_in_proc ]
  original_irbrc_proc[ ]  if original_irbrc_proc
}



# # # # #
# general shortcuts & helper methods
require File.expand_path('irbtools/general', File.dirname(__FILE__) )

# # # # #
# irb options
IRB.conf[:AUTO_INDENT]  = true                 # simple auto indent
IRB.conf[:EVAL_HISTORY] = 42424242424242424242 # creates the special __ variable
IRB.conf[:SAVE_HISTORY] = 2000                 # how many lines will go to ~/.irb_history

# prompt
(IRB.conf[:PROMPT] ||= {} ).merge!( {:IRBTOOLS => {
  :PROMPT_I => ">> ",    # normal
  :PROMPT_N => "|  ",    # indenting
  :PROMPT_C => "(>>) ",  # continuing a statement
  :PROMPT_S => "%l> ",   # continuing a string
  :RETURN   => "=> %s \n",
  :AUTO_INDENT => true,
}})

IRB.conf[:PROMPT_MODE] = :IRBTOOLS

# # # # #
# misc

# add current directory to the loadpath
$: << '.'  if RubyVersion.is.at_least? '1.9.2'

# shoter ruby info constants
Object.const_set 'RV', RubyVersion  rescue nil
Object.const_set 'RE', RubyEngine   rescue nil

# load rails.rc
begin 
  if ( ENV['RAILS_ENV'] || defined? Rails ) && Irbtools.railsrc
    load File.expand_path( Irbtools.railsrc )
  end
rescue
end

# # # # #
# workarounds
require File.expand_path('irbtools/workarounds', File.dirname(__FILE__) )

# # # # #
# done :)
puts "Welcome to IRB. You are using #{ RUBY_DESCRIPTION }. Have fun ;)"

# J-_-L
