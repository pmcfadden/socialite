require 'spec_helper'

describe Comment do
  it "should be possible to get the children of the children" do
    top = Comment.new :text => "top"
    middle = Comment.new :parent => top, :text => "middle"
    bottom = Comment.new :parent => middle, :text => "bottom"

    bottom.parent.parent.should eq(top)
  end

  it "should know it the comment is spam or deleted" do
    user = ObjectMother.new_user
    comment = ObjectMother.new_comment :user => user
    comment.spam_or_deleted?.should be(false)

    user.mark_as_deleted
    comment.spam_or_deleted?.should be(true)
  end
end
