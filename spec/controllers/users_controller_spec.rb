require 'spec_helper'

describe UsersController do
  include ControllerMocking

  before(:each) do
    @mock_user = mock_user :admin => true
  end

  describe "spammers" do
    it "assigns the spammers to @users" do
      spammer = ObjectMother.create_user
      ObjectMother.create_submission :user => spammer, :is_spam => true

      get :spammers
      assigns(:users).should == [spammer]
    end
  end

  describe "best of" do
    it "assigns the best users of all time to @users" do
      get :best_of
      assigns(:users).should == [@mock_user]
    end
  end

  describe "GET index" do
    it "assigns all users as @users" do
      User.stub(:page) { [@mock_user] }
      get :index
      assigns(:users).should eq([@mock_user])
    end
  end

  describe "GET show" do
    it "assigns the requested users as @user" do
      User.stub(:find).with("37") { @mock_user }
      get :show, :id => "37"
      assigns(:user).should be(@mock_user)
    end
  end

  describe "GET new" do
    it "assigns a new users as @user" do
      User.stub(:new) { @mock_user }
      get :new
      assigns(:user).should be(@mock_user)
    end
  end

  describe "GET edit" do
    it "assigns the requested users as @user" do
      User.stub(:find).with("37") { @mock_user }
      get :edit, :id => "37"
      assigns(:user).should be(@mock_user)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created user as @user" do
        User.stub(:new).with({'these' => 'params'}) { @mock_user }
        post :create, :user => {'these' => 'params'}
        assigns(:user).should be(@mock_user)
      end

      it "redirects to the created user" do
        User.stub(:new) { @mock_user.stub(:save => true); @mock_user }
        post :create, :user => {}
        response.should redirect_to(user_url(@mock_user))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        User.stub(:new).with({'these' => 'params'}) { @mock_user.stub(:save => false); @mock_user }
        post :create, :user => {'these' => 'params'}
        assigns(:user).should be(@mock_user)
      end

      it "re-renders the 'new' template" do
        User.stub(:new) { @mock_user.stub(:save => false); @mock_user }
        post :create, :user => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested users" do
        User.stub(:find).with("37") { @mock_user }
        @mock_user.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :user => {'these' => 'params'}
      end

      it "assigns the requested user as @user" do
        User.stub(:find) { @mock_user }
        put :update, :id => "1", :user => {}
        assigns(:user).should be(@mock_user)
      end

      it "redirects to the users list" do
        User.stub(:find) { @mock_user }
        put :update, :id => "1", :user => {}
        response.should redirect_to(users_path)
      end
    end

    describe "with invalid params" do
      it "assigns the user as @user" do
        @mock_user.stub(:update_attributes => false)
        User.stub(:find) { @mock_user }
        put :update, :id => "1", :user => {}
        assigns(:user).should be(@mock_user)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested user" do
      @mock_user.should_receive(:mark_as_deleted)
      @mock_user.should_receive(:save!)
      User.stub(:find).with("37") { @mock_user }
      delete :destroy, :id => "37"
    end

    it "redirects to the users list" do
      @mock_user.should_receive(:mark_as_deleted)
      @mock_user.should_receive(:save!)
      User.stub(:find) { @mock_user }
      delete :destroy, :id => "1"
      response.should redirect_to(users_path)
    end
  end

end
