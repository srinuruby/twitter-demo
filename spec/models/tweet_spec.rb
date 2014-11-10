require 'spec_helper'

describe Tweet do
  it "Tweet with blank content" do
    invalid_tweet = FactoryGirl.build(:tweet, :content=>'')
    invalid_tweet.should_not be_valid
    invalid_tweet.errors.messages[:content].should include("Whoops! You didnt enter any text...")
  end

  it "Tweet with space as content" do
    invalid_tweet = FactoryGirl.build(:tweet, :content=>'   ')
    invalid_tweet.should_not be_valid
    invalid_tweet.errors.messages[:content].should include("Whoops! You didnt enter any text...")
  end

  it "Tweet with blank user_id" do
    invalid_tweet = FactoryGirl.build(:tweet, :user_id=> nil)
    invalid_tweet.should_not be_valid
    invalid_tweet.errors.messages[:user_id].should include("can't be blank")
  end

  it "Tweet with same content and user_id" do
    tweet = FactoryGirl.create(:tweet)
    invalid_tweet = FactoryGirl.build(:tweet)
    invalid_tweet.should_not be_valid
    invalid_tweet.errors.messages[:content].should include("Whoops! You already tweeted that...")
  end

  it "Tweet with more than 160 chars" do
    invalid_tweet = FactoryGirl.build(:tweet, :content=>'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nec purus in ante pretium blandit. Aliquam erat volutpat. Nulla libero lectus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nec purus in ante pretium blandit. Aliquam erat volutpat. Nulla libero lectus.')
    invalid_tweet.should_not be_valid
    invalid_tweet.errors.messages[:content].should include("Whoops! You can only enter upto 160 chars...")
  end

  it "Valid tweet" do
    FactoryGirl.build(:tweet).should be_valid
  end

  it "Valid tweet with exactly 160 chars" do
    FactoryGirl.build(:tweet,:content=>"Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolo").should be_valid
  end
end
