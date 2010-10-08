# shows the contents of your current directory (more such commands available by FileUtils)
def ls(path='.')
  Dir[ File.join( path, '*' )].map{|res| res =~ /^#{path}\/?/; $' }
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
