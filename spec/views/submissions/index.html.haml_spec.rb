require 'spec_helper'

describe "submissions/index.html.haml" do
  before(:each) do
    assign(:submissions, [
      stub_model(Submission,
        :title => "Title",
        :url => "Url",
        :description => "MyText"
      ),
      stub_model(Submission,
        :title => "Title",
        :url => "Url",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of submissions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
