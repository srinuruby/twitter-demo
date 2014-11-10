require 'spec_helper'
describe FollowersController do
  include Devise::TestHelpers
  handle_session
  describe "follower controller methods" do
    context "list of followings" do
      it "get list of followings"  do
        get :following, {:username=>'test'}
        expect(response.status).to eq(200)
      end

      it "get list of followings of current_user instead of test2 as it doesnot exists"  do
        get :following, {:username=>'test2'}
        expect(response.status).to eq(200)
      end
    end

    context "list of followers" do
      it "get list of followers"  do
        get :follower, {:username=>'test'}
        expect(response.status).to eq(200)
      end

      it "get list of followers of current_user instead of test2 as it doesnot exists"  do
        get :follower, {:username=>'test2'}
        expect(response.status).to eq(200)
      end
    end

    context "Follower create" do
      it "successfull creation"  do
        request.env["HTTP_REFERER"] = "http://test.host/"
        post :follow, {:id=>2}
        expect(response.status).to eq(302)
        expect(flash[:notice]).to eq("You are successfully following this person")
        expect(@user.followings.count).to eq(1)
      end

      it "unsuccessfull creation"  do
        request.env["HTTP_REFERER"] = "http://test.host/"
        post :follow, {:id=>@user.id}
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq("Whoops! you cannot follow urself...")
        expect(@user.followings.count).to eq(0)
      end

      it "unsuccessfull creation duplicate"  do
        request.env["HTTP_REFERER"] = "http://test.host/"
        FactoryGirl.create(:follower, :user_id=>@user.id)
        post :follow, {:id=>2}
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq("Whoops! already following this person...")
        expect(@user.followings.count).to eq(1)
      end
    end

    context "Destroy the Follower" do
      it "destroy follower"  do
        request.env["HTTP_REFERER"] = "http://test.host/"
        follower = FactoryGirl.create(:follower, :user_id=>@user.id)
        delete :destroy, {:id=>follower.id}
        expect(response.status).to eq(302)
        expect(flash[:notice]).to eq("Person successfully removed from the following list...")
        expect(@user.followings.count).to eq(0)
      end

      it "destroy follower unsuccessfull"  do
        request.env["HTTP_REFERER"] = "http://test.host/"
        follower = FactoryGirl.create(:follower, :user_id=>-1)
        delete :destroy, {:id=>follower.id}
        expect(response.status).to eq(302)
        expect(Follower.count).to eq(1)
      end

    end
  end
end