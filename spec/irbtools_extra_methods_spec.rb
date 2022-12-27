require "irbtools"

describe "irbtools extra methods" do
  describe "[introspection]" do
    describe "code()" do
      it "delegates to Code.for() to show the method's source code" do
        allow(Code).to receive(:for)
        code "require"
        expect(Code).to have_received(:for)
      end
    end

    describe "mf()" do
      it "returns the MethodFinder class object when no arguments given" do
        expect(mf).to equal(MethodFinder)
      end

      it "delegates to MethodFinder.find() when arguments given" do
        allow(MethodFinder).to receive(:find)
        mf("bla")
        expect(MethodFinder).to have_received(:find)
      end
    end
  end

  describe "[utils]" do
    describe "page()" do
      it "will page long content" do
        allow(Hirb::Pager).to receive(:command_pager)
        page "idiosyncratic"
        expect(Hirb::Pager).to have_received(:command_pager)
      end
    end

    describe "colorize()" do
      it "delegate to CodeRay.scan to syntax highlight given string" do
        allow(CodeRay).to receive(:scan).and_return(CodeRay::TokensProxy.new("", :ruby))
        colorize "def hello() end"
        expect(CodeRay).to have_received(:scan)
      end
    end

    describe "ray()" do
      it "delegate to CodeRay.scan to syntax highlight given file" do
        allow(CodeRay).to receive(:scan).and_return(CodeRay::TokensProxy.new("", :ruby))
        allow(File).to receive(:read).and_return("stuff")
        ray "/tmp/something"
        expect(File).to have_received(:read)
        expect(CodeRay).to have_received(:scan)
      end
    end

    describe "copy()" do
      it "delegate to Clipboard.copy to copy string to clipboard" do
        allow(Clipboard).to receive(:copy)
        copy "idiosyncratic"
        expect(Clipboard).to have_received(:copy)
      end
    end

    describe "paste()" do
      it "delegate to Clipboard.paste to paste clipboard contents" do
        allow(Clipboard).to receive(:paste)
        paste
        expect(Clipboard).to have_received(:paste)
      end
    end

    describe "copy_input()" do
      it "Copies everything you have entered in this IRB session to the clipboard" do
        # pending
      end
    end

    describe "copy_output()" do
      it "Copies the output of all IRB commands from the current IRB session to the clipboard" do
        # pending
      end
    end
  end
end
