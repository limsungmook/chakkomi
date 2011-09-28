class StoreController < ApplicationController
  def index
    @products = Product.all
    @cart = current_cart
    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @cart }
    end
  end

  def show
    @cart = current_cart
    @product = Product.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.js

    end

  end

end
