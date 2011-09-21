# -*- coding: utf-8 -*-

class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy


  def add_product(product_id)
    retval = Hash.new
    current_item = line_items.find_by_product_id(product_id)
    if current_item
      if current_item.quantity < current_item.product.stock
        current_item.quantity += 1
      else
        retval["notice"] = '해당 아이템의 재고만큼 장바구니에 넣었습니다.^^'
      end
    else
      current_item = line_items.build(:product_id => product_id)
    end
    retval["current_item"] = current_item
    return retval
  end


  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def total_items
    line_items.sum(:quantity)
  end
  

end
