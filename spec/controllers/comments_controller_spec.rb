require 'spec_helper'

describe CommentsController do
  include Devise::TestHelpers
  include ControllerMocking

  before(:each) do
    @current_user = mock_user
    @mock_comment = mock_comment
  end

  describe "POST create" do
    describe "with valid params" do
      it "saves a new comment to database" do
        Comment.stub(:new).with({'these' => 'params', "user" => @current_user}) { @mock_comment }
        post :create, :format => 'js', :comment => {'these' => 'params'}
        assigns(:comment).should be(@mock_comment)
      end
    end
  end
end
