class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, :presence => true

  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :karma

  has_many :submissions

  after_initialize :setup_default_values

  def setup_default_values
    self.karma ||= 0
  end

  def increment_karma
    self.karma += 1
  end

  def to_s
    self.username
  end
end
