class ApplicationController < ActionController::Base
  protect_from_forgery
  def index
  	if current_user.blank?
  		redirect_to '/users/sign_in'
    else
      redirect_to "/#{current_user.username}"
  	end
  end
  def after_sign_in_path_for(resource)
    "/#{current_user.username}"
  end
end
