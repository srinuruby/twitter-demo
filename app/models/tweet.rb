class Tweet < ActiveRecord::Base
  attr_accessible :content, :public, :user_id
  validates :user_id, :presence => true
  validate :tweet_validator
  belongs_to :user

  def tweet_validator
    if self.content.blank?
      errors.add(:content, "Whoops! You didnt enter any text...")
    elsif self.content.strip.length > 160
      errors.add(:content, "Whoops! You can only enter upto 160 chars...")
    elsif !Tweet.where(:content=>self.content, :user_id => self.user_id).first.blank? and Tweet.where(:content=>self.content, :user_id => self.user_id).first.id != self.id
      errors.add(:content, "Whoops! You already tweeted that...")
    end
  end

  def change(type)
    if type=="public"
      self.public = true
    elsif type=="private"
      self.public = false
    end
    self.save
  end

  def self.retweet(base_tweet, user_id)
    tweet = Tweet.new(:content=>base_tweet.content, :user_id=>user_id, :public=>false)
    if tweet.save
      return true
    else
      return tweet
    end
  end
end