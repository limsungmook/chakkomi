class Relay < ActiveRecord::Base
  belongs_to :user
  belongs_to :talk

  validates :content, :presence => true
  attr_accessible :content

  default_scope :order => 'relays.created_at asc'
end
