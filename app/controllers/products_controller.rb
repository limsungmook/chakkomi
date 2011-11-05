# -*- coding: utf-8 -*-

class ProductsController < ApplicationController
  # GET /products
  # GET /products.xml
  def index
    if params[:category_id].nil?
      @products = Product.all
    else
      @products = Post.find(:all, :conditions => ["item_category_id = ?", params[:category_id]])
      params[:category_id] = nil
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])
    @product_options = @product.product_options.all

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new
    @product.item_category_id = params[:id]


    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.xml
  def create
    @item_category = ItemCategory.new(:item_category_id => params[:item_category_id])
    @product = @item_category.products.build(params[:product])
    @check_tests = params[:product_option]

    respond_to do |format|
      if @product.save
        if !@check_tests.nil?
        @check_tests.each do |check|        
          @product_option = ProductOption.new()
          @product_option.option = check[1]
          @product_option.product_id = @product.id
          @product_option.save
          end
        end

#        format.html { render :template => 'item_categories/show'}


        format.html { redirect_to '/item_categories/' + @product.item_category.id.to_s }
#        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
#        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to '/item_categories/' + @product.item_category.id.to_s }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|


      format.html { redirect_to :back}
      format.xml  { head :ok }
    end
  end
  def restore_stock
    @products = Product.where("default_stock > 0");
    @products.each do |product|
      product.stock = product.default_stock
    end
  end

end
