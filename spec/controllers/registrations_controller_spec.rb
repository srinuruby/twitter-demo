require 'spec_helper'

describe RegistrationsController do
  include Devise::TestHelpers
  before(:all) do
    User.delete_all
    @user = FactoryGirl.create(:user)
  end
  describe "GET #new" do
    it "renders the :new view with status 200" do
      get :new
      response.should render_template :new
      expect(response.status).to eq(200)
    end
  end
  describe "POST #create" do
    context "with valid attributes" do
      it "redirects to the home page after signin with status 302"  do
        post :create, :user=>{"email"=>"abc@gmail.com", "password"=>@user.password, "password_confirmation"=>@user.password, "name"=>'Parteek Singla', "username"=>'abcdef'}
        #expect(response.body).to eq("<html><body>You are being <a href=\"http://test.host/\">redirected</a>.</body></html>")
        expect(response.status).to eq(302)
      end
    end
    context "with invalid attributes" do
      it "takes to the signup with status 200 because no password confirmation"  do
        post :create, :user=>{"email"=>@user.email, "password"=>@user.password}
        expect(response.status).to eq(200)
      end
      it "takes to the signup page with status 200 and user already exists"  do
        post :create, :user=>{"email"=>@user.email, "password"=>@user.password, "password_confirmation"=>@user.password}
        expect(response.status).to eq(200)
      end
    end
  end
end
describe RegistrationsController do
  include Devise::TestHelpers
  handle_session
  describe "Registrations#new" do
    context "Signup with existing session should not be possible" do
      it "redirects to the home page with status 302 "  do
        get :new
        expect(flash[:alert]).to eq('You are already signed in.')
        expect(response.body).to eq("<html><body>You are being <a href=\"http://test.host/test\">redirected</a>.</body></html>")
        expect(response.status).to eq(302)
      end
    end
  end
end