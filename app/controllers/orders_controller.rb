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
      
  def success
    
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
    
    @user_info = Info.find(:first, :conditions => ["user_id = ?", current_user.id])
    
    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/1/edit
  def edit
    authorize! :manage, :all
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.xml
  def create
    @cart = current_cart
    if params[:info_id].nil?
      info = Info.new
      info.user_id = current_user.id
    else
      info = Info.find(:first, params[:info_id])
    end
    
    info.name = params[:info_name]
    info.email = params[:info_email1] + '@' + params[:info_email2]
    info.phone = params[:info_phone1] + '-' + params[:info_phone2] + '-' + params[:info_phone3]
    info.tel = params[:info_tel1] + '-' + params[:info_tel2] + '-' + params[:info_tel3]
    info.zip1 = params[:info_zip1]
    info.zip2 = params[:info_zip2]
    info.address1 = params[:info_address1]
    info.address2 = params[:info_address2]
    info.save



    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(current_cart)
    @order.user_id = current_user.id
    if params[:phone1].nil? || params[:phone2].nil? || params[:phone3].nil? 
      flash[:phone_error] = '핸드폰 번호를 입력해주세요'
    end
      
    @order.phone = params[:phone1] + '-' + params[:phone2] + '-' + params[:phone3]
    @order.tel = params[:tel1] + '-' + params[:tel2] + '-' + params[:tel3]
    @order.zipcode = params[:zip1] + '-' + params[:zip2]
    @order.address = params[:address1] + ' ' + params[:address2]
    @order.arrival_payment = params[:arrival_payment]
    if @order.arrival_payment == '선불'
      @order.total_price = params[:total_price].to_i + Order::DELIVERY_COST
    else
      @order.total_price = params[:total_price]

    end
    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to(@order, :notice => '주문이 성공적으로 작성되었습니다. 임금이 확인되면 즉시 배송해드리겠습니다 ^-^') }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
        format.js
      else
        format.html { redirect_to('/store/#/orders/new', :notice => "오류가 발생했습니다") }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    authorize! :manage, :all
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
    authorize! :manage, :all
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end
end
