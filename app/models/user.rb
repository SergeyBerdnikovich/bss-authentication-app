class User < ActiveRecord::Base

  has_secure_password

  attr_accessible :email, :login, :password, :password_confirmation, :full_name, :two_step_auth
  has_one :role, dependent: :destroy

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

    def self.authenticate(login, password)
       user = User.find_by_login(login).try(:authenticate, password)
        if user
          return user
        else
          user = User.find_by_email(login).try(:authenticate, password)
          if user
            return user
          else
            user = nil
          end
        end
        user
    end
end
