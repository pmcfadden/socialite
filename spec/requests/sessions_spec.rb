require 'spec_helper'

describe Devise::SessionsController do
  include ControllerMocking

  describe "create a new session" do
    it "should not allow a deleted user to sign in" do
      user = ObjectMother.create_user :deleted => true

      lambda { post user_session_path, :user => {:username => user.username, :password => '123456'} }.should raise_error

      user.deleted = false
      user.save!
      post user_session_path, :user => {:username => user.username, :password => '123456'}
      # OK
    end
  end

end

