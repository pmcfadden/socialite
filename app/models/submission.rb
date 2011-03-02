class Submission < ActiveRecord::Base
  default_scope where(:score => 0)
  def vote_up
    self.score += 1
    self
  end
end
