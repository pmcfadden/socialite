class Submission < ActiveRecord::Base
  before_validation :default_values

  def default_values
    self.score ||= 0
  end

  def vote_up
    self.score += 1
    self.save
    self
  end
end
