module ApplicationHelper
  def time_ago_in_words_including_ago time
    return nil if time.nil?
    "#{time_ago_in_words(time)} ago"
  end
end
