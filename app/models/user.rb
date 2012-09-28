class User < ActiveRecord::Base
  attr_accessible :email, :login, :password, :password_confirmation
  has_one :role, dependent: :destroy

  validates :login, presence: "true"
  				,uniqueness: "true"
  validates :email, presence: "true"
  				,uniqueness: "true"	
  validates :password, presence: "true"							
  validates_confirmation_of :password
  

end
