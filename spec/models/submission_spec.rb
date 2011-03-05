require 'spec_helper'

describe Submission do
  it 'should start with a score of 0' do
    submission = Submission.new(:user => User.new)
    submission.score.should eq(0)
  end
  
  it 'increases the score when you vote it up' do
    submission = Submission.new(:user => User.new)
    submission.vote_up.score.should eq(1)
  end

  it "should return only the top-level comments" do
    parent_comment = Comment.new
    child_comment = Comment.new(:parent => parent_comment)
    submission = Submission.new(:comments => [parent_comment, child_comment])
    
    submission.top_level_comments.should eq([parent_comment])
  end
end
