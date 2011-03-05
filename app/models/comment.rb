class Comment < ActiveRecord::Base
  has_many :children, :class_name => "Comment", :foreign_key => "parent_id"
  belongs_to :parent, :class_name => "Comment"
  belongs_to :submission
  belongs_to :user
  validates :user, :presence => true
  default_scope :order => "created_at DESC"

  def has_parent
    !self.parent.nil?
  end
end
