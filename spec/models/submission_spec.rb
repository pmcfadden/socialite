require 'spec_helper'

describe Submission do

  it "should not pull the deleted or spam submissions" do
    legit_submission = ObjectMother.create_submission :is_spam => false
    spam_submission = ObjectMother.create_submission :is_spam => true
    deleted_user = ObjectMother.create_user :deleted => true
    submission_from_deleted_user = ObjectMother.create_submission :user =>  deleted_user

    list = Submission.list
    list.should include(legit_submission)
    list.should_not include(spam_submission)
    deleted_user.deleted?.should be(true)
    submission_from_deleted_user.deleted?.should be(true)
    list.should_not include(submission_from_deleted_user)
  end
  
  it 'should start with a score of 0' do
    submission = Submission.new(:user => User.new)
    submission.score.should eq(0)
  end
  
  it 'increases the score when you vote it up' do
    submission = Submission.new(:user => User.new)
    submission.vote_up(User.new).score.should eq(1)
  end

  it "should return only the top-level comments" do
    parent_comment = Comment.new
    child_comment = Comment.new(:parent => parent_comment)
    submission = Submission.new(:comments => [parent_comment, child_comment])
    
    submission.top_level_comments.should eq([parent_comment])
  end

  it "should calculate interestingness correctly" do
    now = Time.now
    that = Submission.new(:created_at => now, :score => 2)
    other = Submission.new(:created_at => now, :score => 3)

    assert that.interestingness < other.interestingness
  end

  it "should consider a week-old submission with 50 points to be as interesting as a new one" do
    now = Time.now
    poor_submission = Submission.new(:created_at => now, :score => 0)
    good_submission = Submission.new(:created_at => now, :score => 2)
    old_submission = Submission.new(:created_at => now - 1.week, :score => 51)

    assert poor_submission.interestingness < old_submission.interestingness
    assert good_submission.interestingness > old_submission.interestingness
  end

  it "should turn all urls into absolute urls" do
    Submission.new(:url => "example.com").url.should eq("http://example.com")
    Submission.new(:url => "http://example.com").url.should eq("http://example.com")
  end

  it "should not allow two votes from the same user" do
    voter = User.new
    submission = Submission.new(:user => User.new)
    submission.vote_up(voter).vote_up(voter).score.should eq(1)
  end

  it "should not allow a user to vote for their own submission" do
    user = User.new
    submission = Submission.new(:user => user)
    submission.vote_up(user).score.should eq(0)
  end
end
