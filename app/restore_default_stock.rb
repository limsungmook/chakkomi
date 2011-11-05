# -*- coding: utf-8 -*-

class RestoreDefaultStocks < ActiveRecord::Base
  @products = Product.where("default_stock > 0");
  if @products
    @products.each do |product|
      product.stock = product.default_stock
      product.save
    end
      puts "제품의 기본 제고가 업데이트되었습니다."
  end
end
