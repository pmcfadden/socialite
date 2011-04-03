class AdminController < ApplicationController
  before_filter :require_admin!

  def index
  end

  def moderate_comments
    @comments = Comment.order("created_at DESC").page params[:page]
  end

  def moderate_submissions
    @submissions = Submission.unscoped.order("created_at DESC").page params[:page]
  end

  def save_about_page
      AppSettings.update_settings params[:app_settings]
      redirect_to :modify_about_page, :notice => 'The new about page was saved.'
  end

  def save_app_name
      AppSettings.update_settings params[:app_settings]
      redirect_to :change_name, :notice => 'The new name was saved.'
  end

  def send_test_email
    address = params[:test_email][:email]
    begin
      TestEmailMailer.send_test_email(address).deliver
      flash[:notice] = "Test email sent. You should soon receive an email at #{address}."
    rescue Exception => e
      flash[:alert] = "Could not send test email: #{e}"

      logger.warn flash[:alert]
      logger.warn e.backtrace
    end
    redirect_to :confirmation_email_settings
  end

  def save_confirmation_email_settings
    begin
      new_settings = turn_ones_and_zeros_into_booleans params[:app_settings]
      new_settings[:smtp_port] = new_settings[:smtp_port].to_i if new_settings[:smtp_port]

      AppSettings.update_settings new_settings
      
      # set this now so all mailers can use it
      ActionMailer::Base.default_url_options[:host] = AppSettings.smtp_default_url_host

      redirect_to :confirmation_email_settings, :notice => 'Settings saved.'

    rescue ActiveRecord::RecordInvalid
      flash[:alert] = $!.message
      render :action => "confirmation_email_settings"
    end
  end

  def mark_comment_as_spam
    submission = Comment.find params[:id]
    mark_resource_as_spam submission
  end

  def mark_submission_as_spam
    submission = Submission.find params[:id]
    mark_resource_as_spam submission
  end

  def mark_resource_as_spam submission
    submission.mark_as_spam
    Antispam.new.switch_to_spam submission
    submission.save
    render :text => "({id: #{submission.id}, message: '#{I18n.t 'marked_as_spam'}'})"
  end
  
  def undo_mark_comment_as_spam
    submission = Comment.find params[:id]
    undo_mark_resource_as_spam submission
  end

  def undo_mark_submission_as_spam
    submission = Submission.find params[:id]
    undo_mark_resource_as_spam submission
  end

  def undo_mark_resource_as_spam submission
    submission.is_spam = false
    submission.save
    Antispam.new.switch_to_content submission
    render :text => "({id: #{submission.id}, message: '#{I18n.t 'no_longer_marked_as_spam'}'})"
  end

  private
  def turn_ones_and_zeros_into_booleans parameters
      parameters.each do |k,v|
        v = v == "1" ? true : v
        v = v == "0" ? false : v
        parameters[k] = v
      end
      parameters
  end
end
