require "spec_helper"

describe Hood::Variable do
  describe "#initialize" do
    it "should set @name to the passed name" do
      Hood::Variable.new("FOO").name.should == "FOO"
    end

    it "should set @default to the :default option" do
      var = Hood::Variable.new("FOO", :default => "LOL")
      var.instance_variable_get(:@default).should == "LOL"
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

  describe "#fulfill!" do
    context "if the variable has a default" do
      let(:var) { Hood::Variable.new("FOO", :default => "LOL") }

      context "if the variable is not set" do
        it "should set the ENV variable" do
          var.fulfill!
          ENV["FOO"].should == "LOL"
        end

        it "should not throw an exception" do
          lambda { var.fulfill! }.should_not raise_error
        end
      end

      context "if the variable is set" do
        before(:each) { ENV["FOO"] = "ORLY" }

        it "should leave the ENV var as is" do
          var.fulfill!
          ENV["FOO"].should == "ORLY"
        end

        it "should not throw an exception" do
          lambda { var.fulfill! }.should_not raise_error
        end
      end
    end

    context "the variable is optional" do
      let(:var) { Hood::Variable.new("FOO", :optional => true) }

      context "if the variable is set" do
        before(:each) { ENV["FOO"] = "LOL" }

        it "should not raise an exception" do
          lambda { var.fulfill! }.should_not raise_error
        end
      end

      context "if the variable is not set" do
        it "should not raise an exception" do
          lambda { var.fulfill! }.should_not raise_error
        end
      end
    end

    context "the variable is not optional" do
      let(:var) { Hood::Variable.new("FOO") }

      context "if the variable is set" do
        before(:each) { ENV["FOO"] = "LOL" }

        it "should not raise an exception" do
          lambda { var.fulfill! }.should_not raise_error
        end
      end
      
      context "if the variable is not set" do
        it "should raise an UnfulfilledVariableEror with the proper message" do
          message = "Missing required environment variable 'FOO'"
          lambda { var.fulfill! }.should raise_error(Hood::UnfulfilledVariableError, message)
        end
      end
    end
  end
end
