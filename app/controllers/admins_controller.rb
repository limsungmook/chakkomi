class AdminsController < ApplicationController
  # GET /admins
  # GET /admins.xml
  def index
  end

  def show
  end

  def order_list
    if params[:order] == 'name'
      @orders = Order.page(params[:page]).order('name DESC')
    elsif params[:order] == 'deposit'
      @orders = Order.page(params[:page]).order('deposit_check DESC')
    else
      @orders = Order.page(params[:page]).order('created_at DESC')
    end

    respond_to do |format|
      format.html
    end
  end


end
