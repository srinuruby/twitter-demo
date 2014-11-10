require 'spec_helper'
describe TweetsController do
  include Devise::TestHelpers
  handle_session
  describe "tweet controller methods" do
    context "list of tweets" do
      it "get list of tweets"  do
        get :index, {:username=>'test'}
        expect(response.status).to eq(200)
      end

      it "get list of tweets of current_user instead of test2 as it doesnot exists"  do
        get :index, {:username=>'test2'}
        expect(response.status).to eq(200)
      end
    end
    context "Tweet create" do
      it "successfull creation"  do
        request.env["HTTP_REFERER"] = "http://test.host/"
        tweet = FactoryGirl.build(:tweet)
        post :create, {:tweet=>{:content=>tweet.content, :public=>tweet.public}}
        expect(response.status).to eq(302)
        expect(flash[:notice]).to eq("Tweet Successfully created")
        expect(@user.tweets.count).to eq(1)
      end

      it "Tweet already exists"  do
        request.env["HTTP_REFERER"] = "http://test.host/"
        tweet = FactoryGirl.create(:tweet, :user_id=>@user.id)
        post :create, {:tweet=>{:content=>tweet.content, :public=>tweet.public}}
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq("Whoops! You already tweeted that...")
        expect(@user.tweets.count).to eq(1)
      end

      it "Tweet with no content"  do
        request.env["HTTP_REFERER"] = "http://test.host/"
        tweet = FactoryGirl.build(:tweet, :content=>'')
        post :create, {:tweet=>{:content=>tweet.content, :public=>tweet.public}}
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq("Whoops! You didnt enter any text...")
        expect(@user.tweets.count).to eq(0)
      end

      it "Tweet with content having more than 160 chars"  do
        request.env["HTTP_REFERER"] = "http://test.host/"
        tweet = FactoryGirl.build(:tweet, :content=>'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nec purus in ante pretium blandit. Aliquam erat volutpat. Nulla libero lectus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nec purus in ante pretium blandit. Aliquam erat volutpat. Nulla libero lectus.')
        post :create, {:tweet=>{:content=>tweet.content, :public=>tweet.public}}
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq("Whoops! You can only enter upto 160 chars...")
        expect(@user.tweets.count).to eq(0)
      end
    end
    context "Tweet change" do
      it "tweet change to public"  do
        request.env["HTTP_REFERER"] = "http://test.host/"
        tweet = FactoryGirl.create(:tweet, :user_id=>@user.id)
        get :change, {:id=>tweet.id, :type=>"public"}
        expect(response.status).to eq(302)
        expect(flash[:notice]).to eq("Tweet changed successfully...")
        expect(@user.tweets[0].public).to eq(true)
      end

      it "tweet change to private"  do
        request.env["HTTP_REFERER"] = "http://test.host/"
        tweet = FactoryGirl.create(:tweet, :user_id=>@user.id, :public=>true)
        get :change, {:id=>tweet.id, :type=>"private"}
        expect(response.status).to eq(302)
        expect(flash[:notice]).to eq("Tweet changed successfully...")
        expect(@user.tweets[0].public).to eq(false)
      end

      it "changing the tweet of other user"  do
        request.env["HTTP_REFERER"] = "http://test.host/"
        tweet = FactoryGirl.create(:tweet, :public=>true)
        get :change, {:id=>tweet.id, :type=>"private"}
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq("Whoops! You cannot change this tweet...")
        expect(tweet.public).to eq(true)
      end
    end
    context "Retweet" do
      it "retweet the public tweet"  do
        request.env["HTTP_REFERER"] = "http://test.host/"
        tweet = FactoryGirl.create(:tweet, :public=>true)
        get :retweet, {:id=>tweet.id}
        expect(response.status).to eq(302)
        expect(flash[:notice]).to eq("Tweet successfully created")
        expect(@user.tweets.count).to eq(1)
      end

      it "retweet the public tweet duplicate"  do
        request.env["HTTP_REFERER"] = "http://test.host/"
        tweet = FactoryGirl.create(:tweet, :public=>true)
        tweet2 = FactoryGirl.create(:tweet, :user_id=>@user.id)
        get :retweet, {:id=>tweet.id}
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq("Whoops! You already tweeted that...")
        expect(@user.tweets.count).to eq(1)
      end

      it "retweet the private tweet unsuccessfull"  do
        request.env["HTTP_REFERER"] = "http://test.host/"
        tweet = FactoryGirl.create(:tweet)
        get :retweet, {:id=>tweet.id}
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq("Whoops! You cannot retweet this tweet...")
        expect(@user.tweets.count).to eq(0)
      end
    end
    context "Destroy the tweet" do
      it "destroy tweet"  do
        request.env["HTTP_REFERER"] = "http://test.host/"
        tweet = FactoryGirl.create(:tweet, :user_id=>@user.id)
        delete :destroy, {:id=>tweet.id}
        expect(response.status).to eq(302)
        expect(flash[:notice]).to eq("Tweet removed successfully...")
        expect(@user.tweets.count).to eq(0)
      end

      it "destroy tweet unsuccessfull"  do
        request.env["HTTP_REFERER"] = "http://test.host/"
        tweet = FactoryGirl.create(:tweet)
        delete :destroy, {:id=>tweet.id}
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq("Whoops! You cannot delete this tweet...")
        expect(Tweet.count).to eq(1)
      end

    end
  end
end