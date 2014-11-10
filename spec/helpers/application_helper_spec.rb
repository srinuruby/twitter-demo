require "spec_helper"

describe ApplicationHelper do
  before(:all) do
    User.delete_all
  end
  describe "#can_follow" do
    it "returns true" do
      user = FactoryGirl.create(:user)
      second_user = FactoryGirl.create(:user, :username=>'seconduser', :email=>'seconduser@gmail.com')
      helper.can_follow(user,second_user).should be_true
    end

    it "returns false" do
      user = FactoryGirl.create(:user)
      helper.can_follow(user,user).should be_false
    end

    it "returns false" do
      user = FactoryGirl.create(:user)
      second_user = FactoryGirl.create(:user, :username=>'seconduser', :email=>'seconduser@gmail.com')
      FactoryGirl.create(:follower, :user_id=>user.id, :follower_id=>second_user.id)
      helper.can_follow(user,second_user).should be_false
    end

    it "returns true" do
      user = FactoryGirl.create(:user)
      second_user = FactoryGirl.create(:user, :username=>'seconduser', :email=>'seconduser@gmail.com')
      FactoryGirl.create(:follower, :user_id=>user.id, :follower_id=>second_user.id)
      helper.can_follow(second_user,user).should be_true
    end

  end

  describe "#can_unfollow" do
    it "returns false" do
      user = FactoryGirl.create(:user)
      second_user = FactoryGirl.create(:user, :username=>'seconduser', :email=>'seconduser@gmail.com')
      helper.can_unfollow(user,second_user).should be_false
    end

    it "returns false" do
      user = FactoryGirl.create(:user)
      helper.can_unfollow(user,user).should be_false
    end

    it "returns false" do
      user = FactoryGirl.create(:user)
      second_user = FactoryGirl.create(:user, :username=>'seconduser', :email=>'seconduser@gmail.com')
      follow = FactoryGirl.create(:follower, :user_id=>user.id, :follower_id=>second_user.id)
      helper.can_unfollow(user,second_user).should be(follow.id)
    end

    it "returns true" do
      user = FactoryGirl.create(:user)
      second_user = FactoryGirl.create(:user, :username=>'seconduser', :email=>'seconduser@gmail.com')
      FactoryGirl.create(:follower, :user_id=>user.id, :follower_id=>second_user.id)
      helper.can_unfollow(second_user,user).should be_false
    end

  end
end