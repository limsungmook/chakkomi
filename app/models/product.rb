# -*- coding: utf-8 -*-

class Product < ActiveRecord::Base
  belongs_to :item_category
  has_many :line_items
  has_many :product_options, :dependent => :destroy
  before_destroy :ensure_not_referenced_by_any_line_item
 

  DEFAULT_OPTION = [ "기본옵션", "0.5mm", "1.0mm" ]
  STATE = [ "판매중", "판매중지" , "품절", "문의요망" ]

  validates_attachment_content_type :thumnail_pic, :content_type => [ 'image/jpeg', 'image/png', 'image/gif', 'image/x-png', 'image/pjpeg' ]
  validates_attachment_content_type :detail_pic, :content_type => [ 'image/jpeg', 'image/png', 'image/gif', 'image/x-png', 'image/pjpeg' ]
  has_attached_file :thumnail_pic, :styles => { :thumb => "150x100>" }
  has_attached_file :detail_pic, :styles => { :detail => "310x310>" }
#   has_attached_file :content_pic
  
  default_scope :order => 'created_at DESC'



  private
  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end

end
