class User < ActiveRecord::Base
  attr_accessible :email, :login, :password, :password_confirmation, :full_name, :two_step_auth
  has_one :role, dependent: :destroy

  before_create :encrypted_user_password
  before_update :encrypted_user_password

  validates :login, presence: "true",
  					uniqueness: "true",
  					:length => { :minimum => 3, :maximum => 25, }
  validates :email, presence: true,
   					:length => { :minimum => 5, :maximum => 50, },
   					:uniqueness => true,
            		:format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}	
 validates :full_name,
            :length => { :minimum => 6, :maximum => 60, },
            :format => {:with => /[A-Z][a-z]+ [A-Z][a-z]+/}
  validates :password, presence: "true",
                    :length => { :minimum => 3, :maximum => 40 },
                    :confirmation =>true
  validates :password_confirmation, :presence => true
 
    def self.encrypted_password(password, salt)
        string_to_hash = password + "wibble" + salt
        Digest::SHA1.hexdigest(string_to_hash)
    end 

    def self.authenticate(login, password)
      	user = self.find_by_login(login)
		    if user
  	      expected_password = encrypted_password(password, user.salt)
  	      if user.password != expected_password
  	         user = nil
  	      end
  	    else
  	    	user = self.find_by_email(login)
  	    	if user
  	     		expected_password = encrypted_password(password, user.salt)
  	      		if user.password != expected_password
  	        	user = nil
  	      		end
  	      end	
  	    end
        user
    end
    private

    def encrypted_user_password
      self.salt = UsersHelper.create_new_salt
      self.password = UsersHelper.set_user_password(self.password, self.salt)
    end
end
