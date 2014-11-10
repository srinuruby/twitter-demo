require 'spec_helper'

describe User do
  before(:all) do
    User.delete_all
  end
  context 'Invalid user' do
    it "blank email" do
      invalid_user = FactoryGirl.build(:user, :email=>'')
      invalid_user.should_not be_valid
      invalid_user.errors.messages[:email].should include("can't be blank")
    end

    it "blank username" do
      invalid_user = FactoryGirl.build(:user, :username=>'')
      invalid_user.should_not be_valid
      invalid_user.errors.messages[:username].should include("can't be blank")
    end

    it "blank name" do
      invalid_user = FactoryGirl.build(:user, :name=>'')
      invalid_user.should_not be_valid
      invalid_user.errors.messages[:name].should include("can't be blank")
    end

    it "blank password" do
      invalid_user = FactoryGirl.build(:user, :password=>'')
      invalid_user.should_not be_valid
      invalid_user.errors.messages[:password].should include("can't be blank")
    end

    it "Email already used" do
      user = FactoryGirl.create(:user)
      invalid_user = FactoryGirl.build(:user, :username=>'blah')
      invalid_user.should_not be_valid
      invalid_user.errors.messages[:email].should include("has already been taken")
    end

    it "Username already used" do
      user = FactoryGirl.create(:user)
      invalid_user = FactoryGirl.build(:user, :email=>'testuser@example.com')
      invalid_user.should_not be_valid
      invalid_user.errors.messages[:username].should include("has already been taken")
    end

  end
  context 'Valid User' do
    it "creates a user" do
      FactoryGirl.build(:user).should be_valid
    end
  end
  context 'Check followers and followings' do
    it "creates a user" do
      user = FactoryGirl.create(:user)
      second_user = FactoryGirl.create(:user, :username=>'seconduser', :email=>'seconduser@gmail.com')
      FactoryGirl.create(:follower, :user_id=>user.id, :follower_id=>second_user.id)
      expect(user.followings.length).to be(1)
      expect(user.followers.length).to be(0)
      expect(second_user.followings.length).to be(0)
      expect(second_user.followers.length).to be(1)
    end
  end
end
