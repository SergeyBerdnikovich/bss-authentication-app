class OauthController < ApplicationController
  def start
    oauth = get_oauth
    redirect_to oauth.url_for_oauth_code(:permissions=>"email")
  end

  def callback
    if params[:error]
      flash[:msg] = params[:error_description]
      redirect_to login_path
    else
      oauth = get_oauth
      graph = Koala::Facebook::API.new(oauth.get_access_token(params[:code]))
      @email_and_name = graph.get_object("/me?fields=name,email")
      @user = User.find_from_facebook(@email_and_name)
      session[:user_id] = @user.id
      redirect_to profile_path(@user.id)	
    end
  end

  def get_oauth
    Koala::Facebook::OAuth.new(APP_ID, APP_SECRET,REDIRECT_URI)
  end
end
