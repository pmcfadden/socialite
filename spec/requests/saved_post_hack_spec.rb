require 'spec_helper'

describe 'Using the saved post hack:' do
  def sign_in_from current_url
      get "/sign_in_then_redirect?current_url=#{current_url}"
      response.status.should == 302
      response.location.should == new_user_session_url

      post_via_redirect user_session_path, :user => {:username => @user.username, :password => '123456'}
      response.status.should == 200
      path.should == current_url
  end

  def register_as_new_user_from current_url
      get "/sign_in_then_redirect?current_url=#{current_url}"
      response.status.should == 302
      response.location.should == new_user_session_url

      get new_user_registration_path
      response.status.should == 200

      post_via_redirect users_path, :user => {:username => "test-user-#{Time.now.to_f}", :email => 'example@example.com', :password => '123456', :password_confirmation => '123456'}
      response.status.should == 200
      path.should == current_url
  end

  before(:each) do
    @user = ObjectMother.create_user
    @submission = ObjectMother.create_submission
  end

  describe "voting up a comment when not signed in" do
    it "should go through after signing in" do
      initial_score = @submission.score

      post vote_up_path(@submission)
      response.status.should == 401
      @submission.score.should == initial_score

      sign_in_from root_path

      @submission.reload
      @submission.score.should == initial_score + 1
    end
  end

  describe "voting up a comment when not signed in" do
    it "should go through after registering as a new user" do
      initial_score = @submission.score

      post vote_up_path(@submission)
      response.status.should == 401
      @submission.score.should == initial_score

      register_as_new_user_from root_path

      @submission.reload
      @submission.score.should == initial_score + 1
    end
  end

  describe "leaving a comment when not signed in" do
    it "should go through after signing in" do
      post comments_path, :comment => {:text => 'test-comment', :submission_id => @submission.id}, :format => 'js'
      response.status.should == 401
      @submission.comments.size.should == 0

      sign_in_from submission_path(@submission)

      @submission.reload
      @submission.comments.size.should == 1
    end
  end

end

