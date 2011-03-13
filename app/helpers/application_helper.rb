module ApplicationHelper
  def time_ago_in_words_including_ago time
    return nil if time.nil?
    "#{time_ago_in_words(time)} ago"
  end

  def link_to_unless_current_action action_name, text, path
    return text if action_name == controller.action_name
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
end
