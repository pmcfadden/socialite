require 'spec_helper'

describe StatisticsController do
  include ControllerMocking

  before(:each) do
    @current_user = mock_user
  end

  describe "index" do
    it "should load up statistics" do
      Statistics.stub(:load){{}}
      get :index
      assigns(:statistics).should == {}
    end
  end

end
