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

describe "UsersHelper" do
	before(:each) do
		@user = User.create!(:login=> 'aaa', :password=> 'bbbasdas', :email=> 'asdasd@dsd.dd', :full_name=>"Sasfdas Fasdas", :two_step_auth=>true, :password_confirmation => "bbbasdas")
        session[:user_id] = @user.id
        @user.role = Role.new(role: "Admin")
		
    end
	describe "current_user" do
	    it "has correct return value" do
            helper.current_user.should be_a_kind_of User
	    end
    end
    describe "is_admin?" do
        it "has be true" do
            helper.is_admin?.should be_true
        end
        it "has be false" do
            @user2 = User.create! valid_attributes
            session[:user_id] = @user2.id
            @user2.role = Role.new(role: "User")
            helper.is_admin?.should be_false
        end
        it "has be false" do
            session[:user_id] = nil
            helper.is_admin?.should be_false
        end
    end


end