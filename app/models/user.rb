class User < ActiveRecord::Base
  attr_accessible :email, :login, :password, :password_confirmation
  has_one :role, dependent: :destroy

  

  validates :login, presence: "true",
  					uniqueness: "true",
  					:length => { :minimum => 3, :maximum => 25, }
  validates :email, presence: true,
   					:length => { :minimum => 5, :maximum => 50, },
   					:uniqueness => true,
            		:format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}	
  validates :password, presence: "true",
  					:confirmation => true							
  #validates :password_confirmation, :presence => true
   
    def self.encrypted_password(password, salt)
        string_to_hash = password + "wibble" + salt
        Digest::SHA1.hexdigest(string_to_hash)
    end			
    def create_new_salt
        self.salt = self.object_id.to_s + rand.to_s
    end
    def user_password=(pwd)
        return if pwd.blank?
        create_new_salt
        self.password = User.encrypted_password(pwd, self.salt)
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
end
