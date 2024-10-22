# -*- coding: utf-8 -*-
class LineItemsController < ApplicationController

  def reduce_one
    @cart = current_cart
    @line_item = LineItem.find(params[:id])
    @line_item.sub_line_item

    respond_to do |format|
      if @line_item.quantity < 1 
        @line_item.destroy
        format.html { redirect_to(:action => 'index', :controller => 'store') }
        format.js   { @current_item = @line_item }
        format.xml  { render :xml => @line_item, :status => :deleted, :location => @line_item }
      else 
        if @line_item.save
          format.html { redirect_to(:action => 'index', :controller => 'store') }
          format.js   { @current_item = @line_item }
          format.xml  { render :xml => @line_item, :status => :deleted, :location => @line_item }
        else
          format.html { render :action => "delete" }
          format.xml  { render :xml => @line_item.errors, :status => :unprocessable_entity }
        end
      end
    end

  end
  # GET /line_items
  # GET /line_items.xml
  def index
    @line_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @line_items }
    end
  end

  # GET /line_items/1
  # GET /line_items/1.xml
  def show
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @line_item }
    end
  end

  # GET /line_items/new
  # GET /line_items/new.xml
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @line_item }
    end
  end

  # GET /line_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
  end

  # POST /line_items
  # POST /line_items.xml
  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @line_item = @cart.line_items.find_by_product_id(product.id)
    if @line_item
      if params[:quantity].to_i < @line_item.product.stock
        if !params[:option].nil?
          @line_item.option = params[:option]
        end
        @line_item.quantity = params[:quantity]
      end
    else
      if params[:option].nil?
        @line_item = @cart.line_items.build(:product_id => product.id, :quantity => params[:quantity])
      else
        @line_item = @cart.line_items.build(:product_id => product.id, :quantity => params[:quantity], :option => params[:option])
      end
    end
      
#    @retval = Hash.new
#    @retval = @cart.add_product(product.id)    

#    @line_item = @retval["current_item"]
#    if @retval["notice"]
#      flash[:notice] = @retval["notice"]
#    end
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to(:action => 'index', :controller => 'store') }
        format.js   { @current_item = @line_item }
        format.xml  { render :xml => @line_item, :status => :created, :location => @line_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @line_item.errors, :status => :unprocessable_entity }
      end
    end
  end


  # PUT /line_items/1
  # PUT /line_items/1.xml
  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to(@line_item, :notice => 'Line item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @line_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.xml
  def destroy
    @cart = current_cart
    if params[:check_one]
      @line_items = LineItem.find(params[:check_one])
      @line_items.each do |line_item|
        line_item.destroy
      end
    end
#    @line_item.destroy

#    @line_item = @cart.sub_line_item(params[:id])


    respond_to do |format|
        format.html { redirect_to(:action => 'index', :controller => 'store') }
        format.js 
        format.xml  { render :xml => @line_item, :status => :deleted, :location => @line_item }
    end
  end
end
