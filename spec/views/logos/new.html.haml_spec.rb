require 'spec_helper'

describe "logos/new.html.haml" do
  before(:each) do
    assign(:logo, stub_model(Logo).as_new_record)
  end

  it "renders new logo form" do
    render
    assert_select "form", :action => logo_path, :method => "post" do
    end
  end
end
