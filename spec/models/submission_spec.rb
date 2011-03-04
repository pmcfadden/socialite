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
end
