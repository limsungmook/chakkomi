class RestoreDefaultStocks < ActiveRecord::Base
  @products = Product.all
  @products.each do |product|
    product.stock = product.default_stock
    product.save
  end
end
