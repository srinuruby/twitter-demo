class FollowersController < ApplicationController

  def following
    @user = User.where(:username => params[:username]).first
    if @user.blank?
      @user = current_user
    end
    @tweets, @followings, @followers = @user.tweets_followers_following
  end

  def follower
    @user = User.where(:username => params[:username]).first
    if @user.blank?
      @user = current_user
    end
    @tweets, @followings, @followers = @user.tweets_followers_following
  end

  def follow
    @follow = Follower.new(:user_id=>current_user.id, :follower_id=>params[:id])
    if @follow.save
      redirect_to :back, :notice=>'You are successfully following this person'
    else
      redirect_to :back, :alert=>@follow.errors.messages[:follower_id].first
    end
  end


  def destroy
    @follow = Follower.find(params[:id])
    if current_user and current_user.id == @follow.user_id
      @follow.destroy
      redirect_to :back, :notice=>'Person successfully removed from the following list...'
    else
      redirect_to :back, :alert=>'Whoops! You cannot unfollow this person...'
    end
  end
end