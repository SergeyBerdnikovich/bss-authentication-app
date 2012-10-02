require 'spec_helper'

describe "UsersHelper" do
	before(:each) do
		@user = User.create(:login=> 'sergey', :password=> '1234', :email=> 'asdasd@dsd.dd', :full_name=>"Sasfdas Fasdas", :two_step_auth=>true)
	end
	describe "authenticate" do
		xit "has correct return value" do
			User.authenticate(@user.login, @user.password).should be_a_kind_of User
		end

	end

	describe "encrypted_password" do
		it "has correct return value" do
			User.encrypted_password(@user.password, "1234").should match /[0-9a-z]{32}+/
		end
	end
end