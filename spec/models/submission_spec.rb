require 'spec_helper'

describe Submission do
  it 'should start with a score of 0' do
    Submission.new.score.should eq(0)
  end
  
  it 'increases the score when you vote it up' do
    Submission.new.vote_up.score.should eq(1)
  end
end
