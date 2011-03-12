require 'spec_helper'

describe User do
  it "should increase karma as its submissions are voted up" do
    david = User.new
    david.karma.should eq(0)
    Submission.new(:user => david).vote_up User.new
    david.karma.should eq(1)
  end

  it "should list spammers" do
    spammer = ObjectMother.create_user 'spammer'
    legit_user = ObjectMother.create_user 'legit'
    spam_submission = ObjectMother.create_submission :user => spammer, :is_spam => true

    User.find_spammers.all.should include(spammer)
    User.find_spammers.all.should_not include(legit_user)
  end

end
