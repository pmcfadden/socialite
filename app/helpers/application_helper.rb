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
end
