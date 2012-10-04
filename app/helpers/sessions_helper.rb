module SessionsHelper

  def current_user
    	@current_user ||= User.find(session[:user_id]) if session[:user_id]
 	end
  def is_admin?
   	if current_user
   		if @current_user.role.role == "Admin"
     		return true
     		else 
       		return false
     		end
   	end
   	return false
  end

end
