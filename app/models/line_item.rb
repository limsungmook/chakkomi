class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :cart

  def sub_line_item
    if self.quantity >= 0
      self.quantity -= 1
    end
  end

    
  def total_price
    product.price * quantity
  end
end
