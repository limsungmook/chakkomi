# -*- coding: utf-8 -*-
class ProductOptionsController < ApplicationController
  def show
    @product_option = ProductOption.find(params[:id])
  end

  def new
    @product_option = ProductOption.new
    @product_option.product_id = params[:id]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product_option }
    end
  end


  def edit
    @product_option = ProductOption.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @product = Product.new(:id => params[:product_id])
    @product_option = @product.product_options.build(params[:product_option])
    @check_tests = params[:product_option]
    @str = ''
    @check_tests.each do |check|
      @str = @str + check
    end
    
    respond_to do |format|
      if @product_option.save
        format.html { redirect_to('/products/'+  @product_option.product.id.to_s, :notice => '글 작성이 완료되었습니다.') }
#        format.xml  { render :xml => @product_option, :status => :created, :location => @product_option }
      else
        format.html { render :action => "new" }
#        format.xml  { render :xml => @product_option.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /product_options/1
  # PUT /product_options/1.xml
  def update
    @product_option = ProductOption.find(params[:id])
    respond_to do |format|
      if @product_option.update_attributes(params[:product_option])
        format.html { redirect_to('/products/'+  @product_option.product.id.to_s, :notice => '글 수정이 완료되었습니다') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /product_options/1
  # DELETE /product_options/1.xml
  def destroy
    @product_option = ProductOption.find(params[:id])
    @product_option.destroy

    respond_to do |format|
      format.html { redirect_to :back }
#      format.html { redirect_to(product_options_url) }
#      format.xml  { head :ok }
    end
  end

end
