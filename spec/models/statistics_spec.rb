require 'spec_helper'

describe Statistics do
  describe "all" do
    it "should retrieve the bundle of statistics" do
      user = ObjectMother.create_user
      submission = ObjectMother.create_submission :user => user

      stats = Statistics.load
      stats[:number_of_users].should == 1
      stats[:number_of_submissions].should == 1
    end
  end
end
