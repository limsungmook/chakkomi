class StoreController < ApplicationController
  layout "shop"
  def index
    @item_categories = ItemCategory.all
#    @products = Product.all
#    @cart = current_cart
    
    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @cart }
    end
  end

  def show
#    @cart = current_cart
    @item_category = ItemCategory.find(params[:id])
    @products = @item_category.products.all
    @product = @item_category.products.find(:first)

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

end
