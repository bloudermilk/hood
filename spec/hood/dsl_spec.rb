require "spec_helper"

describe Hood::DSL do
  describe ".evaluate" do
    it "should return an instance" do
      with_envfile "Envfile" do
        Hood::DSL.evaluate("Envfile").should be_an_instance_of(Hood::DSL)
      end
    end

    it "should evaluate the file at the passed path" do
      contents = "env 'FOO'"
      with_envfile "Envfile", contents do
        Hood::DSL.evaluate("Envfile").should have(1).variables
      end
    end
  end

  describe "#env" do
    let (:builder) { Hood::DSL.new }

    it "should return an instance of variable" do
      builder.env("FOO").should be_an_instance_of(Hood::Variable)
    end

    it "should add the variable to @variables on the builder" do
      builder.variables.should be_empty
      builder.env "FOO"
      builder.should have(1).variables
    end

    context "when @optional is true" do
      before(:each) { builder.instance_variable_set(:@optional, true) }

      context "when :optional is true" do
        it "should instantiate an optional Variable" do
          builder.env("FOO", :optional => true).should be_optional
        end
      end

      context "when :optional is false" do
        it "should instantiate a required Variable" do
          builder.env("FOO", :optional => false).should_not be_optional
        end
      end

      context "when :optional isn't passed" do
        it "should instantiate an optional Variable" do
          builder.env("FOO").should be_optional
        end
      end
    end

    context "when @optional is false" do
      context "when :optional is true" do
        it "should instantiate an optional Variable" do
          builder.env("FOO", :optional => true).should be_optional
        end
      end

      context "when :optional is false" do
        it "should instantiate a required Variable" do
          builder.env("FOO", :optional => false).should_not be_optional
        end
      end

      context "when :optional isn't passed" do
        it "should instantiate a required Variable" do
          builder.env("FOO").should_not be_optional
        end
      end
    end

    context "when :description is passed" do
      it "should instantiate a Variable with that description" do
        desc = "An awesome variable"
        builder.env("FOO", :description => desc).description.should == desc
      end
    end

    context "when :description isn't passed" do
      it "should not raise an exception" do
        lambda { builder.env("FOO") }.should_not raise_exception
      end
    end

    context "when @prefix is set" do
      before(:each) { builder.instance_variable_set(:@prefix, "FOO_") }

      it "should prepend the prefix to the passed name" do
        builder.env("BAR").name.should == "FOO_BAR"
      end
    end

    context "when @prefix is not set" do
      it "should use the passed name" do
        builder.env("FOO").name.should == "FOO"
      end
    end

    context "when an unknown option is passed" do
      it "should raise an InvalidOption error" do
        lambda { builder.env("FOO", :lol => true) }.should raise_exception(Hood::InvalidOption)
      end

      context "when a single unknown option is passed" do
        it "should format the string nicely" do
          message = "You passed :lol as an option for variable 'FOO', but it is invalid."
          lambda { builder.env("FOO", :lol => true) }.should raise_exception(Hood::InvalidOption, message)
        end
      end

      context "when multiple unknown options are passed" do
        it "should format the string nicely" do
          message = "You passed :lol, :wtf as options for variable 'FOO', but they are invalid."
          lambda { builder.env("FOO", :lol => true, :wtf => false) }.should raise_exception(Hood::InvalidOption, message)
        end
      end
    end

    context "when a string is used as the key to an option" do
      it "should convert the key to a symbol" do
        builder.env("FOO", "description" => "Yeah").description.should == "Yeah"
      end
    end
  end

  describe "#optional" do
    let (:builder) { Hood::DSL.new }

    context "when @optional is false" do
      before(:each) { builder.instance_variable_set(:@optional, false) }

      it "should set @optional to true inside the block" do
        builder.optional do
          builder.instance_variable_get(:@optional).should == true
        end
      end

      it "should change @optional back to false after yielding the back" do
        builder.optional {}
        builder.instance_variable_get(:@optional).should == false
      end
    end

    context "when optional is true" do
      before(:each) { builder.instance_variable_set(:@optional, true) }

      it "should set @optional to true inside the block" do
        builder.optional do
          builder.instance_variable_get(:@optional).should == true
        end
      end

      it "should leave optional as true after yielding the block" do
        builder.optional {}
        builder.instance_variable_get(:@optional).should == true
      end
    end
  end

  describe "#prefix" do
    let (:builder) { Hood::DSL.new }

    context "when there is no existing prefix" do
      it "should set @prefix to the passed prefix inside the block" do
        builder.prefix("FOO") do
          builder.instance_variable_get(:@prefix).should == "FOO"
        end
      end

      it "should change @prefix back to an empty string after yielding the block" do
        builder.prefix("FOO") {}
        builder.instance_variable_get(:@prefix).should be_empty
      end
    end

    context "when two or more prefix blocks are nested" do
      it "should append the passed prefix to @prefix inside the block" do
        builder.prefix("FOO_") do
          builder.prefix("BAR") do
            builder.instance_variable_get(:@prefix).should == "FOO_BAR"
          end
        end
      end

      it "should change @prefix back to its old value after yielding the block" do
        builder.prefix("FOO_") do
          builder.prefix("BAR") {}
          builder.instance_variable_get(:@prefix).should == "FOO_"
        end
      end
    end
  end
end
