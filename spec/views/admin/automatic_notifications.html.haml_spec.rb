require 'spec_helper'

describe "admin/automatic_notifications.html.haml" do
  it "renders the settings" do
    render
    assert_select "form", :action => save_automatic_notifications_path, :method => "post" do
    end
  end
end

