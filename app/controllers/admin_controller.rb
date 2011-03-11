class AdminController < ApplicationController
  before_filter :require_admin!, :except => [:show]

  def index
  end

  def moderate_submissions
    @submissions = Submission.unscoped.order("created_at DESC").page params[:page]
  end

  def mark_as_spam
    submission = Submission.find params[:id]
    submission.mark_as_spam
    Antispam.new.switch_to_spam submission
    submission.save
    render :text => "{id: #{submission.id}, message: '#{I18n.t 'marked_as_spam'}'}"
  end
end
