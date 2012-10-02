require 'spec_helper'

describe "UsersModel" do
	before(:each) do
		@user = User.create(:login=> 'sergey', :password=> 1234, :email=> 'asdasd@dsd.dd', :full_name=>"Sasfdas Fasdas", :two_step_auth=>true)
		@user.password_confirmation = "1234"
	end
	describe "authenticate" do
		xit "has correct return value" do
			#User.authenticate(@user.login, @user.password).should be_a_kind_of User
		end

	end

	describe "user validates" do
		describe "validates :login" do
			it "has valid value" do
				@user.login.should match /[0-9a-zA-Z]{3,25}/
			end
			it "has not be nill" do
				@user.login.should_not be_nil
			end
			xit "has be uniqueness" do
				expect{ @user = User.create(:login=> 'sergey', :password=> '1234', :email=> 'asdasd@dsd.dd', :full_name=>"Sasfdas Fasdas", :two_step_auth=>true) }.to raise_error
			end
		end
		describe "validates :email" do
			it "has valid value" do
				@user.email.should match /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
			end
			it "has correct size" do
				(5..50).should cover(@user.email.size)
			end
			it "has not be nill" do
				@user.email.should_not be_nil
			end
			xit "has be uniqueness" do
				expect{ @user = User.create(:login=> 'sergey', :password=> '1234', :email=> 'asdasd@dsd.dd', :full_name=>"Sasfdas Fasdas", :two_step_auth=>true) }.to raise_error
			end
		end
		describe "validates :full_name" do
			it "has valid value" do
				@user.full_name.should match /[A-Z][a-z]+ [A-Z][a-z]+/
			end
			it "has correct size" do
				(6..60).should cover(@user.full_name.size)
			end
		end
		describe "validates :password" do
			it "has not be nill" do
				@user.password.should_not be_nil
			end
			it "has correct size" do
				(3..40).should cover(@user.password.size)
			end
			it "has correct password_confirmation" do
				@user.password.eql? @user.password_confirmation
			end
		end
		describe "validates :password_confirmation" do
			it "has not be nill" do
				@user.password_confirmation.should_not be_nil
			end
			it "has correct size" do
				(3..40).should cover(@user.password_confirmation.size)
			end
			it "has correct password" do
				@user.password_confirmation.eql? @user.password
			end
		end
		describe "validates :two_step_auth" do
			it "has not be nill" do
				@user.two_step_auth.should_not be_nil
			end
		end
	end
end