class Submission < ActiveRecord::Base
  belongs_to :user
  after_initialize :setup_default_values
  validates :user, :presence => true

  def setup_default_values
    self.score = 0
  end

  def vote_up
    self.score += 1
    self.save
    self
  end
end
