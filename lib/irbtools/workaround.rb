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

# J-_-L
