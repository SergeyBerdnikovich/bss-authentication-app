module UsersHelper

    def gravatar(email)
		return "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.to_s)}?d=wavatar"
	end
	
  protected

	def self.auth_code(email)
    	Digest::SHA512.hexdigest("#{email}:#{salt_for_auth_code}").gsub(/[a-z]/i,"")[0..5]
  	end
  	def self.salt_for_auth_code
    	SecureRandom.hex(32)
    end
<<<<<<< HEAD

end
=======
<<<<<<< HEAD
=======
    def self.set_user_password(pwd, salt)
    	return if pwd.blank?
        password = User.encrypted_password(pwd, salt)
    end		
    def self.create_new_salt
    	#salt = SecureRandom.hex(32)
    	salt = self.object_id.to_s + rand.to_s
    end

>>>>>>> b1ff126bd4c946c79b62444da297046b17d08316
end
>>>>>>> 096d87b09bdf5144263a139a487aced92647e501
