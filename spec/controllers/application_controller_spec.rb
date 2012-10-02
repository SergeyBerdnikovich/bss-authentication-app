require 'spec_helper'

describe "ApplicationController" do
	before(:each) do
		session[:user_id] = 28
		@user = User.create(:login=> 'sergey', :password=> '1234', :email=> 'asdasd@dsd.dd', :full_name=>"Sasfdas Fasdas", :two_step_auth=>true)
		@user.role = Role.create(role: "Admin")
	end
	describe "current_user" do
		xit "has correct return value" do
			current_user.should be_a_kind_of User
		end
	end
	describe "login_required" do
		xit "has correct return value" do
			login_required.should be_true
		end
	end
	describe "check_admin" do
		xit "has correct return value" do
			check_admin.should be_true
		end
	end
	describe "is_admin?" do
		xit "has correct return value" do
			is_admin?.should be_true
		end
	end
end