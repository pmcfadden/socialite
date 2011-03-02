require 'spec_helper'

describe "submissions/edit.html.haml" do
  before(:each) do
    @submission = assign(:submission, stub_model(Submission,
      :title => "MyString",
      :url => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit submission form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => submissions_path(@submission), :method => "post" do
      assert_select "input#submission_title", :name => "submission[title]"
      assert_select "input#submission_url", :name => "submission[url]"
      assert_select "textarea#submission_description", :name => "submission[description]"
    end
  end
end
