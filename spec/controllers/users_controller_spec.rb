require 'spec_helper'

 def valid_attributes
    {
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
      expect(assigns(:users)).to eq(User.all)
    end
  end
  describe "GET show" do
    fixtures :users

    xit "assigns user to @user" do
      get :show
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
      get :show, {:id => user.to_param}
      expect(assigns(:one)).should == "user"
    end
  end
end