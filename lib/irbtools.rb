# encoding: utf-8

if defined?(IRB) || defined?(Ripl)
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
  
  # loading helper proc
  load_libraries_proc = proc{ |libs|
    remember_verbose_and_debug = $VERBOSE, $DEBUG
    $VERBOSE = $DEBUG = false

    libs.each{ |lib|
      begin
        require lib.to_s
        Irbtools.send :library_loaded, lib
      rescue LoadError => err
        warn "Couldn't load an irb library: #{err}"
      end
    }
    $VERBOSE, $DEBUG = remember_verbose_and_debug
  }

  # load: start
  load_libraries_proc[ Irbtools.libraries[:start] ]

  # load: after_rc / sub-session
  if defined?(Ripl) && Ripl.started?
    if defined? Ripl::AfterRc
      Ripl.after_rcs += Irbtools.libraries[:after_rc]
    else
      warn "Couldn't load Irbtools.libraries[:after_rc]. Install ripl-after_rc to use this feature for Ripl"
    end
  else
    original_irbrc_proc = IRB.conf[:IRB_RC]
    IRB.conf[:IRB_RC] = proc{
      load_libraries_proc[ Irbtools.libraries[:after_rc] ]
      original_irbrc_proc[ ]  if original_irbrc_proc
    }
  end

  # load: autoload hooks
  Irbtools.libraries[:autoload].each{ |constant, lib|
    gem lib
    autoload constant, lib
    Irbtools.send :library_loaded, lib
  }

  # # # # #
  # irb options
  unless defined? Ripl
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

  # # # # #
  # misc

  # add current directory to the load path
  $: << '.'  if RubyVersion.is.at_least? '1.9.2'

  # shorter ruby info constants
  Object.const_set :RV, RubyVersion  rescue nil
  Object.const_set :RE, RubyEngine   rescue nil

  # load: rails.rc
  begin
    if  ( ENV['RAILS_ENV'] || defined? Rails ) && Irbtools.railsrc &&
        File.exist?( File.expand_path(Irbtools.railsrc) )
      load File.expand_path(Irbtools.railsrc)
    end
  rescue
  end

  # load: threads
  Irbtools.libraries[:thread].each{ |_,libs|
    Thread.new do
      load_libraries_proc[ libs ]
    end
  }

  # # # # #
  # done :)
  if msg = Irbtools.welcome_message
    puts msg
  end
end

# J-_-L
