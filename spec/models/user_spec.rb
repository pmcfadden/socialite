require 'spec_helper'

describe User do
  it "should increase karma as its submissions are voted up" do
    david = User.new
    david.karma.should eq(0)
    Submission.new(:user => david).vote_up
    david.karma.should eq(1)
  end
end
