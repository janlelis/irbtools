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

# reloading, hints from http://www.themomorohoax.com/2009/03/27/irb-tip-load-files-faster
def rerequire(lib)
  $".delete( "#{lib}.rb" )
  require( lib.to_s )
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

# change ruby version (requires rvm)
autoload :RVM, 'irbtools/rvm'

def rubies
  RVM.current.list_strings
end

def use(which = nil) # TODO with gemsets?
  # show current ruby if called without options
  if !which
    return RVM.current.environment_name[/^.*@|.*$/].chomp('@')
  end

  # start ruby :)
  begin
    RVM.use! which.to_s
  rescue RVM::IncompatibleRubyError => err
    err.message =~ /requires (.*?) \(/
    rubies = RVM.current.list_strings
    if rubies.include? $1
      # remember history...
      run_irb = proc{ exec "#{ $1 } -S #{ $0 }" } 
      if defined?(Ripl) && Ripl.instance_variable_get(:@shell) # ripl is running
        Ripl.shell.write_history if Ripl.shell.respond_to? :write_history
        run_irb.call
      else
        at_exit(&run_irb)
        exit
      end
    else
      warn "Sorry, that Ruby version could not be found (see rubies)!"
    end
  end
end
alias use_ruby use

def gemsets
  RVM.current.gemset.list
end

def gemset(which = nil)
  if which
    if RVM.current.gemset.list.include? which.to_s
      RVM.use! RVM.current.environment_name.gsub /(@.*?$)|$/, "@#{ which }"
    else
      warn "Sorry, that gemset could not be found (see gemsets)!"
    end
  end
  RVM.current.gemset_name
end
alias use_gemset gemset

# load debugger, inspired by rdp
def dbg
  begin
    require 'ruby-debug'
    debugger
  rescue LoadError => err
    throw "Sorry, unable to load ruby-debug gem for debugger: #{err}"
  end
end

class Object
  # display ri entry
  def ri(meth)
    ri_cmd = 'ri'
    if instance_of?( Kernel ) || instance_of?( Object )
      puts `#{ri_cmd} #{meth}`
    elsif is_a? Module
      puts `#{ri_cmd} #{self}.#{meth}`
    else
      puts `#{ri_cmd} #{self.class}##{meth}`
    end
  end
end

# J-_-L
