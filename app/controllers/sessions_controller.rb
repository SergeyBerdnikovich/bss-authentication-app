class SessionsController < ApplicationController
  def new

  end
  def show_code
  	if params[:password] == params[:password_confirmation]
	  	@user = User.authenticate(params[:login], params[:password])
	  	if @user
	  	rnd = Random.new
	  	session[:auth_cod] = rnd.rand(100000..999999)
	  	session[:time] = Time.now

	    else
	    	render 'new'
	    end
	else
		flash[:msg] = "password confirmation invalid"
		render 'new'
	end
  end
  def create
  	if Time.now < session[:time] + 30
	  	if session[:auth_cod].to_s == params[:auth_cod]

	  		session[:user_id] = params[:user_id]
	  		redirect_to users_path
	  	else
	  		flash[:msg] = "autharization code invalid"
	  		render 'new'
	  	end
	else
		flash[:msg] = "30 sec, Time is left!!!"
		render 'new'
	end
  end
  def destroy
  	session[:user_id] = nil
  	redirect_to sessions_new_path
  end
end
