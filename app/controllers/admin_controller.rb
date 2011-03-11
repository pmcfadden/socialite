class AdminController < ApplicationController
  before_filter :require_admin!, :except => [:show]

  def moderate_submissions
    @submissions = Submission.where(:is_spam => nil).page params[:page]
  end

  def mark_as_spam
    submission = Submission.find params[:id]
    submission.mark_as_spam
    Antispam.new.train_as_spam submission
    submission.save
    render :text => "{id: #{submission.id}, message: 'Marked as spam'}"
  end
end
