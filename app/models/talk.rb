class Talk < ActiveRecord::Base
  belongs_to :user
  belongs_to :talk_category
  has_many :relays, :dependent => :destroy
  attr_accessible :content, :secret, :mid

  validates :content, :presence => true
  validates :secret, :presence => true, :numericality => true, :inclusion => { :in => 0..1 }

  default_scope :order => 'talks.updated_at DESC'
end
