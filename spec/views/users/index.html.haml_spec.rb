require 'spec_helper'

describe "users/index.html.haml" do
  it "renders a list of users" do
    ObjectMother.create_user "michael"
    ObjectMother.create_user "jones"
    assign(:users, User.page)
    render
    assert_select "tr>td", :text => /michael/, :count => 1
    assert_select "tr>td", :text => /jones/, :count => 1
  end
end
