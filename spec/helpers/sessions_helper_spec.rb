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
    #include RSpec::Rails::Matchers::RedirectTo
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
    describe "login_required" do
        it "has be true" do
            helper.login_required.should be_true
        end
        xit "has be redirect to sessions_new_path" do
            session[:user_id] = nil
            helper.login_required
            current_path.should eq(sessions_new_path)
        end
    end
    describe "check_admin" do
        it "has be true" do
            helper.check_admin.should be_true
        end
        xit "has be flash[:msg]" do
            @user2 = User.create! valid_attributes
            session[:user_id] = @user2.id
            @user2.role = Role.new(role: "User")
            helper.check_admin
            flash[:msg].should_not be_nil
        end
        xit "has be redirect to users_path" do
            @user2 = User.create! valid_attributes
            session[:user_id] = @user2.id
            @user2.role = Role.new(role: "User")
            helper.check_admin
            current_path.should eq(users_path)
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