require "spec_helper"

describe Hood::DSL do
  describe ".evaluate" do
    it "should return an instance"
    it "should evaluate the file at the passed path"
  end

  describe "#env" do
    it "should return an instance of variable"
    it "should add the variable to @variables on the builder"

    context "when @optional is true" do
      context "when :optional is true" do
        it "should instantiate an optional Variable"
      end

      context "when :optional is false" do
        it "should instantiate a required Variable"
      end

      context "when :optional isn't passed" do
        it "should instantiate an optional Variable"
      end
    end

    context "when @optional is false" do
      context "when :optional is true" do
        it "should instantiate an optional Variable"
      end

      context "when :optional is false" do
        it "should instantiate a required Variable"
      end

      context "when :optional isn't passed" do
        it "should instantiate a required Variable"
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
