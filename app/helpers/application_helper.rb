module ApplicationHelper
  def can_follow(current_user, user)
    if current_user != user and Follower.where(:user_id=>current_user.id, :follower_id => user.id).first.blank?
      return true
    end
    return false
  end

  def can_unfollow(current_user, user)
    if current_user != user and !(follower=Follower.where(:user_id=>current_user.id, :follower_id => user.id).first).blank?
      return follower.id
    end
    return false
  end

end
