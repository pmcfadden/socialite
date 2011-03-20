require 'spec_helper'

describe LogosController do
  include Devise::TestHelpers
  include ControllerMocking

  before(:each) do
    @mock_user = mock_user :admin => true
  end

  def mock_logo(stubs={})
    @mock_logo ||= mock(Logo, stubs)
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created logo as @logo" do
        Logo.stub(:new).with({'these' => 'params'}) { mock_logo(:save => true) }
        post :create, :logo => {'these' => 'params'}
        assigns(:logo).should be(mock_logo)
      end

      it "redirects to the new logo url" do
        Logo.stub(:new) { mock_logo(:save => true) }
        post :create, :logo => {}
        response.should redirect_to(new_logo_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved logo as @logo" do
        logo = mock_logo(:save => false)
        Logo.stub(:new).with({'these' => 'params'}) { logo }
        logo.should_receive(:errors)

        post :create, :logo => {'these' => 'params'}
        assigns(:logo).should be(mock_logo)
      end

      it "re-renders the 'new' template" do
        logo = mock_logo(:save => false)
        Logo.stub(:new) { logo }
        logo.should_receive(:errors)

        post :create, :logo => {}
        response.should render_template("new")
      end
    end
  end

end
