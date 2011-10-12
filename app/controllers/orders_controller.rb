# -*- coding: utf-8 -*-

class OrdersController < ApplicationController
  layout "shop"
  # GET /orders
  # GET /orders.xml

  def zipsearch
    require 'uri'
    require 'net/http'
    require 'iconv'

    dong_name = Iconv.iconv('euc-kr', 'utf-8', params[:query])
    res = Net::HTTP.post_form(URI.parse('http://biz.epost.go.kr/KpostPortal/openapi'), {'regkey' => '18132c774fa887e6d1318210963744', 'target' => 'post', 'query' => dong_name})
    new_response_body = Iconv.iconv('UTF-8//IGNORE', 'euc-kr', res.body).join
    @retval = new_response_body
    respond_to do |format|
      format.xml { render :xml => @retval }
    end
  end
      


  def index

#    @orders = Order.all
    @orders = Order.find(:all, :conditions => ["user_id = ?", current_user.id])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
    @cart = current_cart
    @order = Order.new
    if @cart.line_items.empty?
      redirect_to(:action => 'index', :controller => 'store', :notice => "장바구니가 비어 주문을 할 수 없습니다")
      return
    end

    if @order.check_able_to_order(@cart) == 0
      redirect_to(:action => 'index', :controller => 'store', :notice => "재고가 없어 주문을 할 수 없습니다.")
      return
    end
    

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.xml
  def create
    @cart = current_cart
    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(current_cart)
    @order.user_id = current_user.id
    @order.name = params[:name]
    @order.account_owner = params[:account_owner]
    address = params[:address1] + params[:address2]
    @order.address = address
    @order.total_price = params[:total_price]
    
    if current_user.delivery_address1 != params[:address1] || current_user.delivery_address2 != params[:address2]
      if  current_user.delivery_address1 != params[:address1]
        current_user.delivery_address1 = params[:address1]
      end
      if  current_user.delivery_address2 != params[:address2]
        current_user.delivery_address2 = params[:address2]
      end
      current_user.save
    end

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to(@order, :notice => '주문이 성공적으로 작성되었습니다. 임금이 확인되면 즉시 배송해드리겠습니다 ^-^') }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to(@order, :notice => 'Order was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end
end
