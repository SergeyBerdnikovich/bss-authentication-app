class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def login_required
  	unless current_user
    	redirect_to sessions_new_path
  	end
  end
  def check_admin
        if Role.find_by_user_id(session[:user_id]).role != "Admin"
          flash[:msg] = "insufficient access rights"
          redirect_to users_path
        end
  end

end
