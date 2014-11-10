require 'spec_helper'

describe Follower do

  it "Follower with blank user_id" do
    invalid_follower = FactoryGirl.build(:follower, :user_id=>nil)
    invalid_follower.should_not be_valid
    invalid_follower.errors.messages[:user_id].should include("can't be blank")
  end

  it "Follower with blank follower_id" do
    invalid_follower = FactoryGirl.build(:follower, :follower_id=>nil)
    invalid_follower.should_not be_valid
    invalid_follower.errors.messages[:follower_id].should include("can't be blank")
  end

  it "Follower with duplicate entry" do
    follower = FactoryGirl.create(:follower)
    invalid_follower = FactoryGirl.build(:follower)
    invalid_follower.should_not be_valid
    invalid_follower.errors.messages[:follower_id].should include("Whoops! already following this person...")
  end

  it "Follower with same user_id and follower_id" do
    invalid_follower = FactoryGirl.build(:follower, :follower_id=>1)
    invalid_follower.should_not be_valid
    invalid_follower.errors.messages[:follower_id].should include("Whoops! you cannot follow urself...")
  end

  it "Follower create succesfull" do
    follower = FactoryGirl.create(:follower)
    follower.should be_valid
    expect(Follower.count).to be(1)
  end
end