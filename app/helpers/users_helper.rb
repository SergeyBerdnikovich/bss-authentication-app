module UsersHelper
  def self.auth_code(email)
    Digest::SHA512.hexdigest("#{email}:#{salt_for_auth_code}").gsub(/[a-z]/i,"")[0..5]
  end

  protected

  def self.salt_for_auth_code
    SecureRandom.hex(32)
  end

end
