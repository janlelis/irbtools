# every_day_irb defines some helper methods that might be useful in every-day irb usage

module EveryDayIrb
  VERSION = File.read( File.dirname(__FILE__) + '/../VERSION' ).chomp
  extend self

  # shows the contents of your current directory (more such commands available by FileUtils)
  def ls(path='.')
    Dir[ File.join( path, '*' )].map{|filename| File.basename filename }
  end
  alias dir ls

  # read file contents (also see ray for ruby source files ;) )
  def cat(path)
    File.read path
  end

  # allows concise syntax like rq:mathn
  def rq(lib)
    require lib.to_s
  end

  # load shortcut, not suited for non-rb
  def ld(lib)
    load lib.to_s + '.rb'
  end

  # rerequire, not suited for non-rb, please note: can have non-intended side effects in rare cases
  def rerequire(lib)
    $".dup.each{ |path|
      if path =~ %r</#{lib}\.rb$>
        $".delete path.to_s
        require path.to_s
      end
    }
    require lib.to_s
    true
  end
  alias rrq rerequire

  # restart irb
  def reset!
    # remember history...
    reset_irb = proc{ exec$0 } 
    if defined?(Ripl) && Ripl.respond_to?(:started?) && Ripl.started?
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

  # returns the last lines, needed for some copy_ methods
  def session_history(number_of_lines = nil)
    if !number_of_lines
      if defined?(Ripl) && Ripl.respond_to?(:started?) && Ripl.started?
        number_of_lines = Ripl.shell.line
      else
        number_of_lines = context.instance_variable_get(:@line_no)
      end
    end
    Readline::HISTORY.entries[-number_of_lines...-1]*"\n"
  end
end

include EveryDayIrb

# J-_-L
