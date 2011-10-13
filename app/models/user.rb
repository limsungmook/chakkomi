class User < ActiveRecord::Base
  ROLES = %w[admin moderator member anyone banned]
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,  :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
  :confirmable, :lockable

  has_many :services, :dependent => :destroy
  has_many :talks
  has_many :relays 

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :shortbio, :weburl, :haslocalpw, :role, :delivery_address1, :delivery_address2, :phone


  validates :weburl, :url => {:allow_blank => true}, :length => { :maximum => 50 }
  validates :name, :length => { :maximum => 40 }
  validates :shortbio, :length => { :maximum => 500 }
end
