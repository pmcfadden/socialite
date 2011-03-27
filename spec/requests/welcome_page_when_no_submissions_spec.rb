require 'spec_helper'

describe SubmissionsController do
  include ControllerMocking

  describe "index" do
    it "should be a welcome page if there are no submissions" do
      welcome = /<h1>Welcome<\/h1>/

      get submissions_path
      response.body.should match welcome

      26.times { ObjectMother.create_submission }

      get submissions_path
      response.body.should_not match welcome

      get submissions_path, :page => "2"
      response.body.should_not match welcome
    end
  end

end

