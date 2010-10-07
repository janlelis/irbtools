# encoding: utf-8

# # # # #
# require 'irbtools' in your .irbrc
# see the README file for more information

require File.expand_path('irbtools/configure', File.dirname(__FILE__) )

# # # # #
# load libraries
Irbtools.libs.each{ |lib|
  begin
    require lib # &&
    case lib

    when 'wirble'
      Wirble.init
      Wirble.colorize unless OS.windows?

    when 'hirb'
      Hirb::View.enable

    when 'fileutils'
      include FileUtils::Verbose

    when 'clipboard'
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


    when 'coderay'
      # syntax highlight a string
      def colorize(string)
        puts CodeRay.scan( string, :ruby ).term
      end

      # syntax highlight a file
      def ray(path)
        puts CodeRay.scan( File.read(path), :ruby ).term
      end

    end

  rescue LoadError => err
    if err.to_s =~ /irb_rocket/ && RubyEngine.mri?
      warn "Couldn't load the irb_rocket gem.
You can install it with: gem install irb_rocket --source http://merbi.st"
    else
      warn "Couldn't load an irb library: #{err}"
    end
  end
}

# # # # #
# general shortcuts & helper methods

# shows the contents of your current directory (more such commands available by FileUtils)
def ls(path='.')
  Dir[ File.join( path, '*' )].map{|res| res =~ /^#{path}\/?/; $' }
end
alias dir ls

# patch cd so that it also shows the current directory
def cd(path = '/', *args)
  FileUtils::Verbose.cd path, *args
  ls
end

# read file contents (also see ray for ruby source files ;) )
def cat(path)
  File.read path
end

# allows concise syntax like rq:mathn
def rq(lib)
  require lib.to_s
end

# returns the last lines, needed for some copy_ methods
def session_history(number_of_lines = context.instance_variable_get(:@line_no) )
  Readline::HISTORY.entries[-number_of_lines...-1]*"\n"
end

# restart irb
def reset!
  at_exit { exec$0 } # remember history
  exit
end

def ruby_version(which = nil)
  # test if installed
  unless `rvm -v` =~ /Seguin/
    raise 'Ruby Version Manager must be installed to use this command'
  end

  # show rubies if called without options
  if !which
    puts 'Availabe Rubies: ' +
          `rvm list`.scan( /^(?:  |=>) (.*) \[/ )*", "
    return
  end

  # get irb suffix
  rv = `rvm use #{which}` # e.g. => "\ninfo: Using ruby 1.9.2 p0\n"
                          # it does not change the ruby for the current user
  rv =~ /^.*Using(.*)\n/

  # if ruby is found, start it
  if $1
    ruby_name = File.split( $1 )[-1].tr(' ', '-')
    irbname = $0 + '-' + ruby_name# + '@global'
    at_exit { exec irbname } # remember history
    exit
  else
    puts "Sorry, that Ruby version could not be found."
  end
end
alias use ruby_version

# load debugger, inspired by rdp
def dbg
  begin
    require 'ruby-debug'
    debugger
  rescue LoadError => e 
    throw "Sorry, unable to load ruby-debug gem for debugger: #{e}"
  end  
end


# # # # #
# irb options
IRB.conf[:AUTO_INDENT]  = true                 # simple auto indent
IRB.conf[:EVAL_HISTORY] = 42424242424242424242 # creates the special __ variable
IRB.conf[:SAVE_HISTORY] = 2000                 # how many lines will go to ~/.irb_history

# prompt
IRB.conf[:PROMPT].merge!({:IRBTOOLS => {
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
Object.const_set 'RV', RubyVersion  rescue nil
Object.const_set 'RE', RubyEngine   rescue nil


# # # # #
# workarounds

# irb_rocket stdout problems
if IRB.const_defined? :CaptureIO
  module IRB
    class CaptureIO
      def self.streams
        {
           :stdout => @@current_capture.instance_variable_get( :@out ),
           :stderr => @@current_capture.instance_variable_get( :@err ),
        }
      end

      alias original_capture capture
      def capture(&block)
        @@current_capture = self
        original_capture &block
      end
    end
  end

  # patch methods using stdout
  module Kernel
    private

    alias exec_unpatched exec
    def exec(*args)
      STDOUT.reopen(IRB::CaptureIO.streams[:stdout])
      STDERR.reopen(IRB::CaptureIO.streams[:stderr])
      exec_unpatched *args
    end
  end

  alias dbg_unpatched dbg
  def dbg
    STDOUT.reopen(IRB::CaptureIO.streams[:stdout])
    STDERR.reopen(IRB::CaptureIO.streams[:stderr])
    dbg_unpatched
  end
 
  if Object.const_defined? :InteractiveEditor
    InteractiveEditor::Editors.class_eval do
      editors = %w[vi vim emacs nano mate ed]
      editors.each{ |editor|
        alias_for editor, editor_unpatched = ( editor +  '_unpatched' ).to_sym
        define_method editor do
          STDOUT.reopen(IRB::CaptureIO.streams[:stdout])
          STDERR.reopen(IRB::CaptureIO.streams[:stderr])
          send editor_unpatched
        end
      }
    end
  end
end

# # # # #
# done :)
puts "Welcome to IRB. You are using #{ RUBY_DESCRIPTION }. Have fun ;)"

# J-_-L
