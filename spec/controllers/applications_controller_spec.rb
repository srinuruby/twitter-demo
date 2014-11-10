require 'spec_helper'

describe ApplicationController do
	include Devise::TestHelpers
	describe "GET #index" do 
		it "redirects to /users/sign_in with status 302" do 
			get :index 
			#response.should render_template :new
			expect(response.status).to eq(302)
		end
	end
end
describe ApplicationController do
	include Devise::TestHelpers
	handle_session
	describe "GET #index" do 
		context "with exixting session" do
			it "redirect to user home page with status 302 "  do
				get :index
				expect(response.status).to eq(302)
			end
		end
	end
end