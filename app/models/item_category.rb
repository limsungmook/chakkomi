class ItemCategory < ActiveRecord::Base
  has_many :products, :dependent => :destroy

  has_attached_file :thumnail_pic, :styles => { :thumb => "220x180>" }
  
  attr_accessible :name, :detail, :order, :thumnail_pic

  default_scope :order => 'item_categories.order ASC'
end
