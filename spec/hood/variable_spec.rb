require "spec_helper"

describe Hood::Variable do
  describe "#initialize" do
    it "should set @name to the passed name" do
      Hood::Variable.new("FOO").name.should == "FOO"
    end

    it "should set @description the :description option" do
      description = "So awesome."
      var = Hood::Variable.new("FOO", :description => description)
      var.instance_variable_get(:@description).should == description
    end

    it "should set @optional to the :optional option" do
      var = Hood::Variable.new("FOO", :optional => true)
      var.instance_variable_get(:@optional).should == true
    end

    it "should coerce :optional to a boolean" do
      var = Hood::Variable.new("FOO", :optional => nil)
      var.instance_variable_get(:@optional).should == false
      var = Hood::Variable.new("FOO", :optional => "LOL")
      var.instance_variable_get(:@optional).should == true
    end
  end

  describe "#optional?" do
    context "when @optional is true" do
      it "should return true" do
        Hood::Variable.new("FOO", :optional => true).should be_optional
      end
    end

    context "when @optional is false" do
      it "should return false" do
        Hood::Variable.new("FOO", :optional => false).should_not be_optional
      end
    end
  end
end
