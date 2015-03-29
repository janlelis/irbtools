require_relative 'every_day_irb/version'

require 'cd'

module EveryDayIrb
  extend self
  private

  # shows the contents of your current directory (more such commands available by FileUtils)
  def ls(path = '.')
    Cd.cd.ls(path)
  end

  # patch cd so that it also shows the current directory and got some extras
  def cd(path = nil)
    Cd.cd(path)
  end

  # read file contents (also see ray for ruby source files ;) )
  def cat(path)
    File.read path
  end

  # allows concise syntax like rq:mathn
  def rq(lib)
    require lib.to_s
  end

  # same for require relative
  def rr(lib)
    require_relative lib.to_s
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

  # just clear the screen
  def clear
    system 'clear'
  end

  # restart irb
  def reset!
    # remember history...
    reset_irb = proc{ exec $0 }
    if defined?(Ripl) && Ripl.started?
      Ripl.shell.write_history if Ripl.shell.respond_to? :write_history
      reset_irb.call
    else
      at_exit(&reset_irb)
      exit
    end
  end

  # returns the last lines
  def session_history(number_of_lines = nil)
    if !number_of_lines
      if defined?(Ripl) && Ripl.started?
        number_of_lines = Ripl.shell.line
      else
        number_of_lines = context.instance_variable_get(:@line_no)
      end
    end
    Readline::HISTORY.entries[-number_of_lines...-1]*"\n"
  end
end

