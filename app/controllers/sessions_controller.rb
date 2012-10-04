class SessionsController < ApplicationController
	before_filter :login_required, :only => [:destroy]
  def new
  	#redirect_to users_path if session[:user_id]
  	respond_to do |format|
        format.html
        format.js
    end
  end
  def show_code
  	#if params[:password] == params[:password_confirmation]
	  	@user = User.authenticate(params[:login], params[:password])
	  	if @user
	  		if @user.two_step_auth == true
	  			session[:auth_cod] = UsersHelper.auth_code(@user.email)
	  			session[:time] = Time.now
	  			respond_to do |format|
			        format.html
			        format.js
			    end
	  		else
				session[:user_id] = @user.id
				respond_to do |format|
			        format.html {redirect_to users_path}
			        format.js
			    end
	  			#redirect_to user_path(@user.id)
	  		end	
	    else
	    	flash[:msg] = "password or login invalid"
	    	respond_to do |format|
			    format.html {render 'new'}
			    format.js
			end
	    end
	#else
	#	flash[:msg] = "password confirmation invalid"
	#	render 'new'
	#end
  end
  def create
  	if session[:auth_cod].to_s == params[:auth_cod]
  		if Time.now < session[:time] + 32
  			@user = User.find(params[:user_id])
	  			session[:user_id] = params[:user_id]
	  			session[:auth_cod] = session[:time] = nil
		  	respond_to do |format|
			    format.html {redirect_to users_path}
			    format.js
			end
		else
			flash[:msg] = "30 seconds over..."
			respond_to do |format|
		    	format.html {render 'new'}
		    	format.js
			end
		end
	else
  		flash[:msg] = "autharization code invalid"
  		#session[:auth_cod] = session[:time] = nil
	    respond_to do |format|
		    format.html {render 'new'}
		    format.js
		end
  	end
  end
  def destroy
  	session[:user_id] = nil
  	redirect_to root_path
  end
end
