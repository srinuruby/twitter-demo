class TweetsController < ApplicationController

  def index
    @user = User.where(:username => params[:username]).first
    if @user.blank?
      @user = current_user
      @tweet = Tweet.new
    elsif @user == current_user
      @tweet = Tweet.new
    end
    @tweets, @followings, @followers = @user.tweets_followers_following
  end

  def create
    @tweet = current_user.tweets.build(params[:tweet])
    if @tweet.save
      redirect_to :back, :notice=>'Tweet Successfully created'
    else
      redirect_to :back, :alert=>@tweet.errors.messages[:content].first
    end
  end

  def retweet
    @tweet = Tweet.find(params[:id])
    if current_user and current_user.id != @tweet.user_id and (@tweet.public or !Follower.where(:user_id=>current_user.id, :follower_id => @tweet.user_id).first.blank?) and tweet=Tweet.retweet(@tweet,current_user.id)
      if tweet!=true and !tweet.errors.blank?
        redirect_to :back, :alert=>tweet.errors.messages[:content].first
      else
        redirect_to :back, :notice=>'Tweet successfully created'
      end
    else
      redirect_to :back, :alert=>'Whoops! You cannot retweet this tweet...'
    end
  end

  def change
    @tweet = Tweet.find(params[:id])
    if current_user and current_user.id == @tweet.user_id
      @tweet.change(params[:type])
      redirect_to :back, :notice=>'Tweet changed successfully...'
    else
      redirect_to :back, :alert=>'Whoops! You cannot change this tweet...'
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    if current_user and current_user.id == @tweet.user_id
      @tweet.destroy
      redirect_to :back, :notice=>'Tweet removed successfully...'
    else
      redirect_to :back, :alert=>'Whoops! You cannot delete this tweet...'
    end
  end
end