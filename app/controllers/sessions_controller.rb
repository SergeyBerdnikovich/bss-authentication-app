class SessionsController < ApplicationController
	before_filter :login_required, :only => [:destroy]
	#before_filter :current_user
  def new
  	redirect_to users_path if session[:user_id]
  end
  def show_code
  	if params[:password] == params[:password_confirmation]
	  	@user = User.authenticate(params[:login], params[:password])
	  	if @user
	  		if @user.two_step_auth == true
	  			session[:auth_cod] = UsersHelper.auth_code(@user.email)
	  			session[:time] = Time.now
	  		else
				session[:user_id] = @user.id
	  			redirect_to users_path
	  		end	
	    else
	    	flash[:msg] = "password or login invalid"
	    	render 'new'
	    end
	else
		flash[:msg] = "password confirmation invalid"
		render 'new'
	end
  end
  def create
  	if Time.now < session[:time] + 32 and session[:auth_cod].to_s == params[:auth_cod]
	  		session[:user_id] = params[:user_id]
	  		session[:auth_cod] = session[:time] = nil
	  		redirect_to users_path
 	else
  		flash[:msg] = "autharization code invalid"
  		session[:auth_cod] = session[:time] = nil
  		render 'new'
  	end
  end
  def destroy
  	session[:user_id] = nil
  	redirect_to root_path
  end
end
