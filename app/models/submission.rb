class Submission < ActiveRecord::Base
  belongs_to :user
  after_initialize :setup_default_values
  validates :user, :presence => true
  has_many :comments

  def setup_default_values
    self.score ||= 0
  end

  def vote_up
    self.score += 1
    self.user.increment_karma
    self.save
    self.user.save
    self
  end

  def top_level_comments
    self.comments.reject {|comment| comment.has_parent}
  end
end
