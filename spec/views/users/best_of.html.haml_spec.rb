require 'spec_helper'

describe "users/best_of.html.haml" do
  it "renders the list of users with higest karma" do
    ObjectMother.create_user :username => "michael"
    ObjectMother.create_user :username => "jones"
    assign(:users, User.page)
    render
    assert_select "tr>td", :text => /michael/, :count => 1
    assert_select "tr>td", :text => /jones/, :count => 1
  end
end
