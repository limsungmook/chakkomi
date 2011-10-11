# -*- coding: utf-8 -*-

class Order < ActiveRecord::Base
  after_initialize :default_values
  belongs_to :user
  has_many :line_items, :dependent => :destroy
  
  PAYMENT_TYPES = [ "무통장입금", "신용카드", "계좌이체", "직접주기" ]
  ARRIVAL_PAYMENT = [ "선불", "착불" ]
  POST_COST = 300
  DELIVERY_COST = 3000

  validates :name, :account_owner, :pay_type, :arrival_payment, :total_price, :user_id, :presence => true
  validates :pay_type, :inclusion => PAYMENT_TYPES
  validates :arrival_payment, :inclusion => ARRIVAL_PAYMENT

  def check_able_to_order(cart)
    cart.line_items.each do |item|
      if item.product.stock < item.quantity
        return 0
      end
    end
    return -1
  end

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def default_values
    self.deposit_check ||= '입금대기'
  end
end
