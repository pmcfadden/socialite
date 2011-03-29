require 'spec_helper'

describe "statistics/index.html.haml" do
  it "loads up statistics on the page" do
    assign(:statistics, {})
    render
    assert_select "div.field label", :text => "Total number of users"
  end
end

