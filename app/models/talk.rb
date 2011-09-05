class Talk < ActiveRecord::Base
  belongs_to :user
  has_many :relays
  attr_accessible :content, :secret

  validates :content, :presence => true
  validates :secret, :presence => true, :numericality => true, :inclusion => { :in => 0..1 }

  default_scope :order => 'talks.created_at DESC'
end
