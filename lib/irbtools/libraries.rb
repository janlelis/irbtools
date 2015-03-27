# encoding: utf-8
# default irbtools set of libraries, you can remove any you don't like via Irbtools.remove_library

require 'rbconfig'


# # # load on startup

Irbtools.add_library :yaml


# # # load via thread

# ls, cat, rq, rrq, ld, session_history, reset!, clear, dbg, ...
Irbtools.add_library 'every_day_irb', :thread => :stdlib do
  FileUtils::Verbose
  include EveryDayIrb
end

# print debugging helper (q, mof, re)
Irbtools.add_library 'debugging/q', :thread => 21
Irbtools.add_library 'debugging/mof', :thread => 22
Irbtools.add_library 'debugging/re', :thread => 23
Irbtools.add_library 'debugging/beep', :thread => 24
Irbtools.add_library 'debugging/howtocall', :thread => 25
Irbtools.add_library 'instance', :thread => 30
Irbtools.add_library 'g', :thread => 40 if RbConfig::CONFIG['host_os'] =~ /mac|darwin/

# lets you open vim (or your favourite editor), hack something, save it, and it's loaded in the current irb session
Irbtools.add_library 'interactive_editor', :thread => :stdlib

# object oriented ri method
Irbtools.add_library :ori, :thread => 50 do
  class Object
    # patch ori to also allow shell-like "Array#slice" syntax
    def ri(*args)
      if  args[0] &&
          self == TOPLEVEL_BINDING.eval('self') &&
          args[0] =~ /\A(.*)(?:#|\.)(.*)\Z/
        begin
          klass = Object.const_get $1
          klass.ri $2
        rescue
          super
        end
      else
        super
      end
    end
  end
end

# Object#method_lookup_path (improved ancestors) & Object#methods_for (get this method from all ancestors)
Irbtools.add_library :method_locator, :thread => 60 do
  module MethodLocator
    alias mlp method_lookup_path
  end
end

# view method source :)
Irbtools.add_library :method_source, :thread => 70 do
  class Object
    def src(method_name)
      m = method(method_name)

      source   = m.source || ""
      indent   = source.match(/\A +/)
      comment  = m.comment && !m.comment.empty? ? "#{ m.comment }" : ""
      location = m.source_location ? "# in #{ m.source_location*':' }\n" : ""

      puts CodeRay.scan(
        location + comment + source.gsub(/^#{indent}/,""), :ruby
      ).term
    rescue
      raise unless $!.message =~ /Cannot locate source for this method/

      nil
    end

    # alias source src # TODO activate this without warnings oO
  end
end


# # # load via late

# terminal colors
Irbtools.add_library :paint, :late => true

# result colors, install ripl-color_result for ripl colorization
Irbtools.add_library :wirb, :late => true do
  Wirb.start
end

unless defined?(Ripl) && Ripl.started?
  # use hash rocket and colorful errors/streams
  Irbtools.add_library :fancy_irb, :late => true do
    FancyIrb.start
  end
end


# # # load via late_thread

Irbtools.add_library 'wirb/wp',  :late_thread => :a # ap alternative (wp)

Irbtools.add_library 'paint/pa', :late_thread => :b # colorize a string (pa)

# tables, menus...
Irbtools.add_library :hirb, :late_thread => :hirb do
  Hirb::View.enable :output => { "Object" => {:ancestor => true, :options => { :unicode => true }}},
                    :pager_command => 'less -R'
  extend Hirb::Console

  def page(what, options = {})
    Hirb::Pager.command_pager(what, options = {})
  end

  # page wirb output hacks
  class Hirb::Pager
    alias original_activated_by? activated_by?
    def activated_by?(string_to_page, inspect_mode=false)
      original_activated_by?(Paint.unpaint(string_to_page || ''), inspect_mode)
    end
  end

  class << Hirb::View
    def view_or_page_output(val)
      if defined?(val.inspect)
        view_output(val) || page_output(Wirb.colorize_result_with_timeout(val.inspect), true)
      end
    end
  end

  # colorful border
  table_color = :yellow
  Hirb::Helpers::UnicodeTable::CHARS.each do |place, group|
    Hirb::Helpers::UnicodeTable::CHARS[place] =
    group.each do |name, part|
      if part.kind_of? String
        Hirb::Helpers::UnicodeTable::CHARS[place][name] = Paint[part, *table_color]
      elsif part.kind_of? Hash
        part.each do |special, char|
          Hirb::Helpers::UnicodeTable::CHARS[place][name][special] = Paint[char, *table_color]
        end
      end
    end
  end
end


# # # load via autoload

# information pseudo-constants
Irbtools.add_library 'ruby_info', :autoload => :RubyInfo do
  def info() RubyInfo  end unless defined? info
end

Irbtools.add_library 'os', :autoload => :OS do
  def os() OS          end unless defined? os
end

Irbtools.add_library 'ruby_engine', :autoload => :RubyEngine do
  def engine() RubyEngine  end unless defined? engine
end

Irbtools.add_library 'ruby_version', :autoload => :RubyVersion do
  def version() RubyVersion end unless defined? version
end


# syntax highlight
Irbtools.add_library :coderay, :autoload => :CodeRay do
  # ...a string
  def colorize(string)
    puts CodeRay.scan( string, :ruby ).term
  end

  # ...a file
  def ray(path)
    print CodeRay.scan( File.read(path), :ruby ).term
  end
end

# access the clipboard
Irbtools.add_library :clipboard, :autoload => :Clipboard do
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
end

# small-talk like method finder
Irbtools.add_library :methodfinder, :autoload => :MethodFinder do
  MethodFinder::INSTANCE_METHOD_BLACKLIST[:Object] += [:ri, :vi, :vim, :emacs, :nano, :mate, :mvim, :ed]

  def mf(*args, &block)
    args.empty? ? MethodFinder : MethodFinder.find(*args, &block)
  end
end

