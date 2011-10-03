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
    @line_item = LineItem.new
    @item_category = ItemCategory.find(params[:id])
    @products = @item_category.products.all
    if params[:product_id].nil?
      @product = @item_category.products.find(:first)
    else
      @product = @item_category.products.find(params[:product_id])
    end
    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  def detail
    @line_item = LineItem.new
    @product = Product.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

end
