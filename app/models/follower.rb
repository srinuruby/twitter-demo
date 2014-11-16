class Follower < ActiveRecord::Base
  attr_accessible :follower_id, :user_id
  validates :user_id, :presence => true
  validates :follower_id, :presence => true
  validate :double_entry
  belongs_to :user
  belongs_to :following, :foreign_key => :follower_id, :class_name => 'User'
  def double_entry
    if self.id.blank? and !Follower.where(:user_id => self.user_id, :follower_id => self.follower_id).blank?
      errors.add(:follower_id, 'Whoops! already following this person...')
    elsif self.user_id == self.follower_id
      errors.add(:follower_id, 'Whoops! you cannot follow urself...')
    end
  end
end