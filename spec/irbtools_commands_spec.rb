require "irbtools/commands"

describe "irbtools commands" do
  describe "[introspection]" do
    describe "howtocall" do
      it "supports ri Syntax like String.name or String#gsub" do
        expect(
          IRB::ExtendCommand::Howtocall.transform_args("String.name")
        ).to eq "String, :name"

        expect(
          IRB::ExtendCommand::Howtocall.transform_args("String#gsub")
        ).to eq "String, String.instance_method(:gsub)"
      end
    end
  end
end
