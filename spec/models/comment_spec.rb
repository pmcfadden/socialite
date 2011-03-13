require 'spec_helper'

describe Comment do
  it "should default to not spam" do
    comment = Comment.new
    comment.is_spam?.should be(false)
  end

  it "should be possible to get the children of the children" do
    top = Comment.new :text => "top"
    middle = Comment.new :parent => top, :text => "middle"
    bottom = Comment.new :parent => middle, :text => "bottom"

    bottom.parent.parent.should eq(top)
  end

  it "should know it the user author of the comment was deleted" do
    user = ObjectMother.new_user
    comment = ObjectMother.new_comment :user => user
    comment.spam_or_deleted?.should be(false)

    user.mark_as_deleted
    comment.spam_or_deleted?.should be(true)
  end

  it "should know that it is spam" do
    comment = ObjectMother.new_comment :is_spam => true
    comment.spam_or_deleted?.should be(true)
  end
end
