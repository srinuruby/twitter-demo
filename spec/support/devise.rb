module ControllerMacros
	def handle_session
	    before(:each) do
	      @user = User.new
	      @user.email = "test@gmail.com"
        @user.username = "test"
        @user.name = "test"
	      @user.password='new life'
	      @user.save
	      @request.env["devise.mapping"] = Devise.mappings[:user]
	      sign_in @user
	      subject.current_user.should_not eq(nil)
	    end
	    after(:each) do
	      sign_out @user
	    end
	end
end