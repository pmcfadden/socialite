require 'spec_helper'

describe "submissions/show.html.haml" do
  before(:each) do
    @submission = ObjectMother.create_submission
    assign(:submission, @submission)
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/#{@submission.title}/)
    rendered.should match(/#{@submission.url}/)
    rendered.should match(/#{@submission.description}/)
  end

  it "should render spam or deleted comments with the deletion seal" do
    deleted_user = ObjectMother.create_user :deleted => true
    comment = ObjectMother.create_comment :user => deleted_user, :submission => @submission

    @submission.comments.should include(comment)

    render

    rendered.should_not match(/#{comment.text}/)
    rendered.should match(/-- deleted --/)
  end
end
