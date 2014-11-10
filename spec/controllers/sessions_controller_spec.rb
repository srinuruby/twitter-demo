require 'spec_helper'

describe SessionsController do
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
				post :create, :user=>{"login"=>@user.email, "password"=>@user.password, "remember_me"=>"0"}
				expect(response.body).to eq('<html><body>You are being <a href="http://test.host/testuser">redirected</a>.</body></html>')
				expect(response.status).to eq(302)
      end
      it "redirects to the home page after signin with status 302"  do
        post :create, :user=>{"login"=>@user.username, "password"=>@user.password, "remember_me"=>"0"}
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/testuser">redirected</a>.</body></html>')
        expect(response.status).to eq(302)
      end
    end
	end
end
describe SessionsController do
	include Devise::TestHelpers
	handle_session
	describe "DELETE #destroy" do 
		context "with exixting session" do
			it "redirects to the home page after signout with status 302 "  do
				delete :destroy
				expect(flash[:notice]).to eq('Signed out successfully.')
				expect(response.status).to eq(302)
			end
		end
	end
end