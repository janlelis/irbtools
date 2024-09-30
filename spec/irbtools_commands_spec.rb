require "irbtools/commands"

describe "irbtools commands" do
  describe "[introspection]" do
    describe "howtocall / code" do
      it "support ri Syntax like String.name or String#gsub" do
        expect(
          Irbtools::Command::Howtocall.new(nil).transform_arg("String.name")
        ).to eq "[String, :name]"

        expect(
          Irbtools::Command::Code.new(nil).transform_arg("String#gsub")
        ).to eq "[String, String.instance_method(:gsub)]"
      end

      it "supports question-mark methods" do
        expect(
          Irbtools::Command::Howtocall.new(nil).transform_arg("String#ascii_only?")
        ).to eq "[String, String.instance_method(:ascii_only?)]"
      end
    end
  end
end
