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

  describe "GET new" do
    xit "assigns new user" do
      #visit new_user_path
       visit '/users/new'
      page.should have_content("New User")
    end
  end

  describe "POST create" do
    fixtures :users

    xit "assigns user to @user" do
      post :create
      user = User.create! valid_attributes
      expect(assigns(:one)).to eq(User.first)
    end
  end
  describe "GET show_profile" do
    fixtures :users

    xit "assigns user to @user" do
      get :show_profile, {:id =>  5}
      expect(assigns(:two)).to eq(User.last)
    end
  end
  describe "GET show" do
  	fixtures :users
    xit "assigns the requested user as @user" do
      user = User.create! valid_attributes
      get :show, {:id =>  user.id}
      #visit "/users/#{user.id}"
      #expect(user).to eq(User.find(user.id))
      expect(assigns(:users)).to eq("")
    end
  end
end