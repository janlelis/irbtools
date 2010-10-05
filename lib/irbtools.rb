# encoding: utf-8

# required gems: wirble hirb zucker awesome_print g clipboard guessmethod drx interactive_editory coderay irb_rocket

# either use this file as .irbrc or require 'irbtools' in your .irbrc

# # # # #
# load libraries
irb_libs = ['rubygems',
 'wirble',        # colors
 'hirb',          # active record tables
 'fileutils',     # cd, pwd, ln_s, mv, rm, mkdir, touch ... ;)
 'zucker/env',    # Info, OS, RubyVersion, RubyEngine
 'zucker/debug',  # nice debug printing (q, o, c, .m, .d)
 'ap',            # nice debug printing (ap)
 'yaml',          # nice debug printing (y)
 'g',             # nice debug printing (g) - MacOS only :/
 'clipboard',     # easy clipboard access (copy & paste)
 'guessmethod',   # automatically correct typos (method_missing hook)
 'drx',           # nice tk object inspector (.see)
 'interactive_editor',  # lets you open vim (or your favourite editor), hack something, save it, and it's loaded in the current irb session
 'coderay',       # some nice colorful display ;)
 'irb_rocket',    # put result as comment instead of a new line!
 # 'zucker/all'   # see rubyzucker.info
]

irb_libs.each{ |lib|
  begin
    require lib

    case lib
    when 'wirble'
      Wirble.init
      Wirble.colorize

    when 'hirb'
      Hirb::View.enable

    when 'zucker/env'
      include OS # linux?, windows?, ...
      Zucker.more_aliases! # RV, RE

    when 'fileutils'
      include FileUtils::Verbose

    when 'clipboard'
      def copy(str)
        Clipboard.copy(str)
      end

      def paste
        Clipboard.paste
      end

      def copy_session
        require 'open3'
        Open3.popen3('irb'){ |i,o,e|
          i.puts session_history + "\nexit"
          o.read
          #copy o.read
        }
       # "The session history has been copied to the clipboard."
      end

      def copy_input
        copy session_history
        "The session input history has been copied to the clipboard."
      end
      alias copy_session_input copy_input

      def copy_output
        copy context.instance_variable_get(:@eval_history_values).inspect.gsub(/^\d+ (.*)/, '\1')
        "The session output history has been copied to the clipboard."
      end
      alias copy_session_output copy_output

    when 'coderay'
      def colorize(string)
        puts CodeRay.scan( string, :ruby ).term
      end

      def ray(path)
        puts CodeRay.scan( File.read(path), :ruby ).term
      end

    end

  rescue LoadError => err
    warn "Couldn't load an irb library: #{err}"
  end
}

# # # # #
# shortcuts & helpers

# shows the contents of your current directory (more such commands available by FileUtils)
def ls(path='.')
  Dir[ File.join path, '*' ].map{|res| res =~ /^#{path}\/?/; $' }
end
alias dir ls

# patch cd so that it also shows the current directory
def cd(*args)
  FileUtils::Verbose.cd *args
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
def reset! # restart irb
  exec$0
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
    irbname = $0 + $1.tr(' ', '-') + '@global'
    exec irbname
  else
    puts "Sorry, that Ruby version could not be found."
  end
end
alias use ruby_version

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
# workarounds

# patch exec (irb_rocket bug)
if IRB.const_defined? :CaptureIO
  module Kernel
    alias original_exec exec
    def exec(*args)
      STDOUT.reopen(IRB::CaptureIO.streams[:stdout])
      STDERR.reopen(IRB::CaptureIO.streams[:stderr])
      original_exec *args
    end
  end
  
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
end

# # # # #
# done :)
puts "Welcome to IRB. You are using #{RUBY_DESCRIPTION}. Have fun ;)"

# J-_-L
