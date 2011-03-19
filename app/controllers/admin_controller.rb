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

  def confirmation_email_settings
  end

  def save_confirmation_email_settings
    begin
      AppSettings.update_settings params[:app_settings]
      redirect_to :confirmation_email_settings, :notice => 'Settings saved'

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
    render :text => "{id: #{submission.id}, message: '#{I18n.t 'marked_as_spam'}'}"
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
    render :text => "{id: #{submission.id}, message: '#{I18n.t 'no_longer_marked_as_spam'}'}"
  end
end
