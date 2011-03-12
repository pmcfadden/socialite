require 'spec_helper'

describe "submissions/show.html.haml" do
  include ControllerMocking

  describe "valid scenarios" do
    before(:each) do
      @current_user = ObjectMother.new_user
      @view.stub(:current_user) {@current_user}
      @submission = ObjectMother.create_submission :user => @current_user
      assign(:submission, @submission)
    end

    it "renders attributes and an edit link" do
      render
      rendered.should match(/#{@submission.title}/)
      rendered.should match(/#{@submission.url}/)
      rendered.should match(/#{@submission.description}/)
      rendered.should match(/Edit your submission/)
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

  describe "invalid scenarios" do
    before(:each) do
      @current_user = ObjectMother.new_user
      @view.stub(:current_user, @current_user)
      @submission = ObjectMother.create_submission
      assign(:submission, @submission)
    end
    it "should not render the edit link if the submission is from another user" do
      rendered.should_not match(/Edit your submission/)
    end
  end
end
