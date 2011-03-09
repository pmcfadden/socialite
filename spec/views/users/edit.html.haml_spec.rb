require 'spec_helper'

describe "users/edit.html.haml" do
  before(:each) do
    @user = assign(:users, stub_model(User,
      :username => "MyString",
      :admin => true
    ))
  end

  it "renders the edit users form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_path(@user), :method => "post" do
      assert_select "input#user_username", :name => "user[username]"
    end
  end
end
