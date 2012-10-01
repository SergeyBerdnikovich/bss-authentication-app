require 'spec_helper'

describe "UsersHelper" do
	before(:each) do
		@user = User.create(:login=> 'aaa', :password=> 'bbbasdas', :email=> 'asdasd@dsd.dd', :full_name=>"Sasfdas Fasdas", :two_step_auth=>true)
		#@user.role.role = "Admin"
    end
	describe "gravatar_links" do
	    it "has correct return value" do
	        helper.gravatar(["sergey.berdnikovich@altoros.com"]).should match /http:\/\/www.gravatar.com\/avatar\/[a-z0-9]+\?d=wavatar/
	    end
    end

    describe "salt" do
    	it "has correct return value" do
			UsersHelper.create_new_salt.should match /[0-9]+\.[0-9]+/
    	end
    	it "has correct return value" do
			UsersHelper.salt_for_auth_code.should match /[0-9a-z]{32}/
    	end
    end

    describe "two step auth" do
    	it "has correct return value" do
    		UsersHelper.auth_code(@user.email).should match /[0-9]{6}/
    	end
    end

    describe "password" do
    	it "has correct return value" do
    		UsersHelper.set_user_password(@user.password, "1234").should match /[0-9a-z]{40}/
    	end
    end
end