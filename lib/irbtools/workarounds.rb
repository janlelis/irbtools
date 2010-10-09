# encoding: utf-8

# # # # #
# require 'irbtools' in your .irbrc
# but you could also require 'irbtools/configure' and then call Irbtools.init to modify the loaded libraries
# see the README file for more information

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

  # hacks for hirb - irb_rocket interaction
  module IRB
    class Irb
      alias output_value_unrocket output_value
      def output_value
        return ' ' if @io.nil?
        hirb_output = Hirb::Util.capture_stdout do output_value_unrocket end
        if Hirb::View.did_output?
          print hirb_output
        else
          last = @context.io.prompt + @last_line.split("\n").last
          @io.print(rc + cuu1 + (cuf1*last.length) + " " +
            Wirble::Colorize::Color.escape(:blue) + "#=>" + sgr0 +
            " " + Wirble::Colorize.colorize(@context.last_value.inspect) + cud1)
        end
      end
    end
  end
  
  class << Hirb::View
    def did_output?; @did_output; end

    def render_output(output, options={})
      @did_output = false
      if (formatted_output = formatter.format_output(output, options))
        render_method.call(formatted_output)
        @did_output = true 
        true 
      else 
        false
      end  
    end
  end

end

# J-_-L

