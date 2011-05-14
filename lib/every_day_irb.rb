# every_day_irb defines some helper methods that might be useful in every-day irb usage

module EveryDayIrb
  VERSION = File.read( File.dirname(__FILE__) + '/../VERSION' ).chomp
end

# shows the contents of your current directory (more such commands available by FileUtils)
def ls(path='.')
  Dir[ File.join( path, '*' )].map{|res| res =~ /^#{path}\/?/; $' }
end
alias dir ls

# read file contents (also see ray for ruby source files ;) )
def cat(path)
  File.read path
end

# allows concise syntax like rq:mathn and reloading/requireing
def rq(lib)
  require lib.to_s
end

# rerequire, please note: can have non-intended side effects
def rerequire(lib)
  $".dup.grep(/#{lib}\.rb$/).each{ |path|
    $".delete path.to_s
    require path.to_s
  }
  require lib.to_s
  true
end
alias rrq rerequire

# load shortcut
def ld(lib)
  load lib.to_s + '.rb'
end

# returns the last lines, needed for some copy_ methods
def session_history(number_of_lines = nil)
  if !number_of_lines
    if defined?(Ripl) && Ripl.instance_variable_get(:@shell) # ripl is running
      number_of_lines = Ripl.shell.line
    else
      number_of_lines = context.instance_variable_get(:@line_no)
    end
  end
  Readline::HISTORY.entries[-number_of_lines...-1]*"\n"
end

# restart irb
def reset!
  # remember history...
  reset_irb = proc{ exec$0 } 
  if defined?(Ripl) && Ripl.instance_variable_get(:@shell) # ripl is running
    Ripl.shell.write_history if Ripl.shell.respond_to? :write_history
    reset_irb.call
  else
    at_exit(&reset_irb)
    exit
  end
end

# just clear the screen
def clear
  system 'clear'
end

# load debugger, inspired by rdp
def dbg
  begin
    require 'ruby-debug'
    debugger
  rescue LoadError => err
    throw "Sorry, unable to load ruby-debug gem for debugger: #{err}"
  end
end

# J-_-L
