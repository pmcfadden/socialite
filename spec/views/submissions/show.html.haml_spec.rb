require 'spec_helper'

describe "submissions/show.html.haml" do
  before(:each) do
    user = User.new
    user.id = 1
    @submission = assign(:submission, stub_model(Submission,
      :title => "Title",
      :url => "Url",
      :description => "MyText",
      :user => user
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Url/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
