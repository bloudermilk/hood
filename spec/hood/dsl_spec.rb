require "spec_helper"

describe Hood::DSL do
  describe ".evaluate" do
    it "should return an instance"
    it "should evaluate the file at the passed path"
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
      it "should instantiate a Variable with that description"
    end

    context "when a prefix is set" do
      it "should prepend the prefix to the passed name"
    end

    context "when no prefix is set" do
      it "should use the passed name"
    end

    context "when an unknown option is passed" do
      it "should raise an exception"
    end

    context "when a string is used as the key to an option" do
      it "should convert the key to a symbol"
    end
  end

  describe "#optional" do
    context "when @optional is false" do
      it "should set @optional to true inside the block"
      it "should change @optional back to false after yielding the back"
    end

    context "when optional is true" do
      it "should set @optional to true inside the block"
      it "should leave optional as true after yielding the block"
    end
  end

  describe "#prefix" do
    context "when there is no existing prefix" do
      it "should set @prefix to the passed prefix inside the block"
      it "should change @prefix back to an empty string after yielding the block"
    end

    context "when two or more prefix blocks are nested" do
      it "should append the passed prefix to @prefix inside the block"
      it "should change @prefix back to its old value after yielding the block"
    end
  end
end
