require 'spec_helper'

describe "admin/exception_notifier_settings.html.haml" do
  it "renders the settings" do
    render
    assert_select "form", :action => save_exception_notifier_settings_path, :method => "post" do
    end
  end
end

