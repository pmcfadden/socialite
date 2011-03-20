require 'spec_helper'

describe TestEmailMailer do
  it "should generate a test email" do
    ActionMailer::Base.default_url_options[:host] = 'localhost'
    mail = TestEmailMailer.send_test_email "test@example.com"
    mail.to[0].should == "test@example.com"
  end
end

