class Submission < ActiveRecord::Base
  @@voting_momentum = 12096

  belongs_to :user
  has_many :comments
  has_many :votes

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
    self.url = "http://" + url if !self.url.nil? and self.url !~ /^http:\/\//
  end

  def vote_up user_who_voted
    if not Vote.where(:submission_id => self.id, :user_id => user_who_voted.id).empty?
      puts "User #{user_who_voted} tried to vote twice for submission ##{self.id}"
    elsif user_who_voted == self.user
      puts "User #{user_who_voted} tried to vote for their own submission ##{self.id}"
    else
      self.score += 1
      self.user.increment_karma
      Vote.new(:user => user_who_voted, :submission => self).save
      self.save
      self.user.save
    end
    self
  end

  def top_level_comments
    self.comments.reject {|comment| comment.has_parent}
  end

  def is_spam?
    self.is_spam == true
  end

  def mark_as_spam
    self.is_spam = true
  end

end
