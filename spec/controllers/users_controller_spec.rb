require 'spec_helper'
require 'capybara/rspec'

 def valid_attributes
    {
      id: "55",
      login: "ssergey",
  	  password: "1234",
  	  password_confirmation: "1234",
	    full_name: "Sergey Berdnikovich",
	    email: "ssergey.berdnikovich@altoros.com",
	    two_step_auth: true
    }
  end

describe UsersController do
  describe "GET index" do
    fixtures :users

    it "assigns all users to @users" do
      get :index
      expect(assigns(:users)).to eq(User.order(:login).page 1)
    end
  end

  describe "POST create" do
    it "assigns user to @user (first user is Admin)" do
      post :create
      User.delete_all
      admin = User.create! valid_attributes
      admin.role = Role.new(role: "Admin")
      expect(admin).to eq(User.last)
    end
    xit "assigns user to @user (no Admin)" do
      post :create
      first_user = User.create! valid_attributes
      first_user.role = Role.new(role: "Admin")
      first_user.save
      user2 = User.create!(:login=> 'sergey2', :password=> '1234',:password_confirmation=> '1234', :email=> 'asdasd@dsd.dd', :full_name=>"Sasfdas Fasdas", :two_step_auth=>true)
      user2.role = Role.new(role: "User")
      expect(user2).to eq(User.last)
    end
  end

  describe "GET show" do
  	it "assigns the requested user as @user" do
      @user = User.create! valid_attributes
      session[:user_id] = @user.id
      get :show, {:id =>  @user.id}
      expect(@user).to eq(User.find(@user.id))
    end
    it "assigns the requested user as @user and login_required redirect_to sessions_new_path" do
      @user = User.create! valid_attributes
      get :show, {:id =>  @user.id}
      expect(@user).to eq(User.find(@user.id))
    end
  end
  describe "GET show_profile" do
    it "assigns the requested user as @user" do
      @user = User.create! valid_attributes
      session[:user_id] = @user.id
      get :show_profile, {:id =>  @user.id}
      expect(@user).to eq(User.find(@user.id))
    end
  end
  describe "GET edit" do
    it "assigns the requested user as @user" do
      @user = User.create! valid_attributes
      session[:user_id] = @user.id
      get :edit, {:id =>  @user.id}
      expect(@user).to eq(User.find(@user.id))
    end
  end
  describe "PUT update" do
    it "assigns the requested user as @user" do
      @user = User.create! valid_attributes
      session[:user_id] = @user.id
      put :update, {:id =>  @user.id}
      expect(@user).to eq(User.find(@user.id))
    end
    it "has redirect_to user_path" do
      @user = User.create! valid_attributes
      session[:user_id] = @user.id
      put :update, {:id =>  @user.id}
      @user2 = User.find(@user.id)
      @user2.update_attributes(login: "assergey")
      #response.should redirect_to(@user)
      expect(@user2.login).to eq("assergey")
    end
  end
  describe "DELETE destroy" do
    it "check_admin redirect_to users_path" do
      @user = User.create! valid_attributes
      @user.role = Role.new(role: "User")
      session[:user_id] = @user.id
      delete :destroy, {:id =>  @user.id}
      response.should redirect_to(users_path)
    end
    it "has redirect_to users_path" do
      @user = User.create! valid_attributes
      @user.role = Role.new(role: "Admin")
      session[:user_id] = @user.id
      delete :destroy, {:id =>  @user.id}
      @user.destroy
      response.should redirect_to(users_path)
    end
  end
  describe "GET new" do
    it "assigns the requested user as @user" do
      #@user = User.create! valid_attributes
      #session[:user_id] = @user.id
      get :new
      @user = User.new
      @user.should be_a_kind_of User
    end
  end
end