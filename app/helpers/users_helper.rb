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

end