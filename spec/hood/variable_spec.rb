require "spec_helper"

describe Hood::Variable do
  describe "#initialize" do
    it "should set @name to the passed name"
    it "should set @description the :description option"
    it "should set @optional to the :optional option"
    it "should coerce :optional to a boolean"
  end
end
