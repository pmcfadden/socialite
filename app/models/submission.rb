class Submission < ActiveRecord::Base
  @@voting_momentum = 12096

  belongs_to :user
  has_many :comments

  validates :user, :presence => true
  validates :url, :presence => true
  validates :title, :presence => true
  validates :description, :presence => true

  after_initialize :setup_default_values

  paginates_per 20

  # Here we order by interestingness.
  default_scope :order => "score * #{@@voting_momentum} - strftime('%s','now') + strftime('%s',created_at) DESC"

  # Interestingness is calculated by multiplying the number of votes by a coefficient.
  # The amount of time passed since creation is taken as a penalty.
  # Equivalent ruby code would go like this:
  def interestingness
    self.score * @@voting_momentum - Time.now.to_i + created_at.to_i
  end

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
