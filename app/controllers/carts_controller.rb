# -*- coding: utf-8 -*-
class CartsController < ApplicationController
  layout "shop"
  # GET /carts
  # GET /carts.xml
  def index
    @cart = current_cart
    
    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @carts }
    end
  end

  # GET /carts/1
  # GET /carts/1.xml
  def show
    begin
      @cart = Cart.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to store_url, :notice => 'Invalid cart'
    else
      respond_to do |format|
        format.html # show.html.erb
        format.xml { render :xml => @cart }
      end
    end
  end

  # GET /carts/new
  # GET /carts/new.xml
  def new
    @cart = Cart.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cart }
    end
  end

  # GET /carts/1/edit
  def edit
    @cart = Cart.find(params[:id])
  end

  # POST /carts
  # POST /carts.xml
  def create
    @cart = Cart.new(params[:cart])

    respond_to do |format|
      if @cart.save
        format.html { redirect_to(@cart, :notice => 'Cart was successfully created.') }
        format.xml  { render :xml => @cart, :status => :created, :location => @cart }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cart.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /carts/1
  # PUT /carts/1.xml
  def update
    @cart = Cart.find(params[:id])

    respond_to do |format|
      if @cart.update_attributes(params[:cart])
        format.html { redirect_to(@cart, :notice => 'Cart was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cart.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.xml
  def destroy
    @products = Product.all
    @cart = current_cart
    @cart.destroy
    session[:cart_id] = nil

    respond_to do |format|
      format.html { redirect_to(:action => 'index', :controller => 'store') }
      format.js 
      format.xml  { head :ok }
    end
  end
end
