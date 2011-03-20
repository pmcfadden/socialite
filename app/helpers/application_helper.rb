module ApplicationHelper
  def app_name
    AppSettings.app_name
  end

  def time_ago_in_words_including_ago time
    return nil if time.nil?
    "#{time_ago_in_words(time)} ago"
  end

  def link_to_unless_current_action text, path
    options = Rails.application.routes.recognize_path(path, :method => :get)
    if options[:controller] == controller.controller_name and options[:action] == controller.action_name 
      return text
    end

    link_to text, path
  end

  def current_user_is_admin?
    current_user.try :admin
  end

  def resolve_class_for_coloring_comment comment
    classes = []
    classes << "marked-as-spam" if comment.is_spam?
    classes.join " "
  end

  def resolve_class_for_coloring_submission submission
    classes = []
    classes << "voted" if !current_user.nil? && current_user.voted_for(submission)
    classes << "marked-as-spam" if submission.is_spam?
    classes.join " "
  end

  def resolve_submission_url submission
    submission.url.blank? ? submission_path(submission) : submission.url
  end

end
