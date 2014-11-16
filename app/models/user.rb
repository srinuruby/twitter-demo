class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :username, :profile_url, :active, :login
  validates :username, :presence => true, :uniqueness => true
  validates :name, :presence => true
  has_many :tweets
  has_many :followings, :foreign_key => :user_id, :class_name => 'Follower'
  has_many :followers, :foreign_key => :follower_id, :class_name => 'Follower'

  def tweets_followers_following
    tweets = self.tweets.order('created_at DESC')
    followings = self.followings.order('created_at DESC')
    followers = self.followers.order('created_at DESC')
    return tweets, followings, followers
  end

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
end
