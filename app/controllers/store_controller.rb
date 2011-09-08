class StoreController < ApplicationController
  def index
    @products = Product.all
    @cart = current_cart
  end

  def show
    @cart = current_cart
    @product = Product.find(params[:id])

  end

end
