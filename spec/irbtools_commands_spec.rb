require "irbtools/commands"

describe "irbtools commands" do
  describe "[introspection]" do
    describe "howtocall / code" do
      it "support ri Syntax like String.name or String#gsub" do
        expect(
          IRB::ExtendCommand::Howtocall.transform_args("String.name")
        ).to eq "String, :name"

        expect(
          IRB::ExtendCommand::Code.transform_args("String#gsub")
        ).to eq "String, String.instance_method(:gsub)"
      end

      it "supports question-mark methods" do
        expect(
          IRB::ExtendCommand::Howtocall.transform_args("String#ascii_only?")
        ).to eq "String, String.instance_method(:ascii_only?)"
      end
    end
  end
end
