# -*- coding: utf-8 -*-

class Order < ActiveRecord::Base
  belongs_to :user
  has_many :line_items, :dependent => :destroy
  
  PAYMENT_TYPES = [ "무통장입금", "신용카드", "계좌이체", "직접주기" ]
  DELIVERY_TYPES = [ "일반우편", "택배", "직접수령" ]
  ARRIVAL_PAYMENT = [ "선불", "착불" ]

  validates :name, :account_owner, :pay_type, :delivery_types, :arrival_payment, :presence => true
  validates :pay_type, :inclusion => PAYMENT_TYPES
  validates :delivery_types, :inclusion => DELIVERY_TYPES
  validates :arrival_payment, :inclusion => ARRIVAL_PAYMENT

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
