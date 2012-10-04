class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper

  def login_required
      unless current_user
        redirect_to sessions_new_path
      else
        return true
      end
  end

  def check_admin
    if Role.find_by_user_id(session[:user_id]).role != "Admin"
        flash[:msg] = "insufficient access rights"
        redirect_to users_path
    else
      return true
    end
  end
  
end
