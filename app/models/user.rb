class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, :presence => true
  validates :karma, :presence => true

  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :karma, :deleted

  has_many :submissions

  after_initialize :setup_default_values

  def self.find_spammers
    User.joins(:submissions).where("submissions.is_spam" => true)
  end

  def setup_default_values
    self[:karma] ||= 0
  end

  def increment_karma
    self.karma += 1
  end

  def to_s
    self.attributes['username']
  end

  def mark_as_deleted
    self.deleted = true
  end

end
