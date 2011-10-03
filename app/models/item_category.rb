class ItemCategory < ActiveRecord::Base
  has_many :products, :dependent => :destroy

  has_attached_file :thumnail_pic, :styles => { :thumb => "140x140>" }
  
  attr_accessible :name, :detail, :order, :thumnail_pic
end
