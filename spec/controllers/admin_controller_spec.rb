require 'spec_helper'

describe AdminController do
  include Devise::TestHelpers
  include ControllerMocking

  before(:each) do
    mock_user :admin => true

    @antispam = ObjectMother.initialize_antispam_filter
    Antispam.stub(:new){ @antispam }
    @initial_entry_count = @antispam.trained_entries

  end

  describe "send test email" do
    it "should send a test email through the test email mailer" do
      class FakeEmail; def deliver; end; end
      TestEmailMailer.stub(:send_test_email){FakeEmail.new}

      post :send_test_email, :test_email => {:email => "user@example.com"}

      flash[:notice].blank?.should_not be(true)
      response.should redirect_to(:confirmation_email_settings)
    end
  end

  describe "confirmation email settings" do
    it "should consider a setting of '1' to be true" do 
      post :save_confirmation_email_settings, :app_settings => {:smtp_tls => "1"}
      AppSettings.smtp_tls.should == true
    end

    it "should consider a string like '123' for the port to be a number" do
      post :save_confirmation_email_settings, :app_settings => {:smtp_port => "123"}
      AppSettings.smtp_port.should == 123
    end
  end

  describe "marking comment as spam" do
    it "should mark comment as spam and train the antispam filter" do
      comment = ObjectMother.create_comment :text => 'commenting'

      post :mark_comment_as_spam, :id => comment.id
      @antispam.trained_entries.should == @initial_entry_count + 1
      comment.reload.is_spam?.should == true
      @antispam.is_classified_as_spam?(comment).should == true

      post :undo_mark_comment_as_spam, :id => comment.id
      @antispam.trained_entries.should == @initial_entry_count + 1
      comment.reload.is_spam?.should == false
      @antispam.is_classified_as_spam?(comment).should == false
    end
  end

  describe "marking submission as spam" do
    it "should mark submission as spam and train the antispam filter" do
      @submission = ObjectMother.create_submission :title => 'one', :description => 'two'
      post :mark_submission_as_spam, :id => @submission.id

      @antispam.trained_entries.should == @initial_entry_count + 2
      @submission.reload.is_spam?.should == true
      @antispam.is_classified_as_spam?(@submission).should == true

      post :undo_mark_submission_as_spam, :id => @submission.id
      @antispam.trained_entries.should == @initial_entry_count + 2
      @submission.reload.is_spam?.should == false
      @antispam.is_classified_as_spam?(@submission).should == false
    end
  end

end
