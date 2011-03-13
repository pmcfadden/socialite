require 'spec_helper'

describe User do

  it "should know if user already voted for a submission" do
    user = ObjectMother.create_user
    submission = ObjectMother.create_submission

    user.voted_for(submission).should == false
    ObjectMother.create_vote user, submission
    user.voted_for(submission).should == true
  end

  it "should increase karma as its submissions are voted up" do
    david = User.new
    david.karma.should eq(0)
    Submission.new(:user => david).vote_up User.new
    david.karma.should eq(1)
  end

  it "should list spammers" do
    spammer = ObjectMother.create_user :username => 'spammer'
    legit_user = ObjectMother.create_user :username => 'legit'
    spam_submission = ObjectMother.create_submission :user => spammer, :is_spam => true

    User.find_spammers.all.should include(spammer)
    User.find_spammers.all.should_not include(legit_user)
  end

  it "should mark a user as deleted and do the same for its submissions and comments" do
    user = ObjectMother.new_user :username => 'short-lived'
    submission = ObjectMother.new_submission :user => user
    comment = ObjectMother.new_comment :user => user

    user.mark_as_deleted

    user.deleted?.should be(true)
    submission.deleted?.should be(true)
    comment.deleted?.should be(true)
  end

end
