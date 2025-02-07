class ItemCategoriesController < ApplicationController
#  load_and_authorize_resource
  # GET /item_categories
  # GET /item_categories.json
  def index
    @item_categories = ItemCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @item_categories }
    end
  end

  # GET /item_categories/1
  # GET /item_categories/1.json
  def show
    @item_category = ItemCategory.find(params[:id])
    @products = @item_category.products.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item_category }
    end
  end

  # GET /item_categories/new
  # GET /item_categories/new.json
  def new
    @item_category = ItemCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item_category }
    end
  end

  # GET /item_categories/1/edit
  def edit
    @item_category = ItemCategory.find(params[:id])
  end

  # POST /item_categories
  # POST /item_categories.json
  def create
    @item_category = ItemCategory.new(params[:item_category])

    respond_to do |format|
      if @item_category.save
        format.html { redirect_to @item_category, notice: 'Item category was successfully created.' }
        format.json { render json: @item_category, status: :created, location: @item_category }
      else
        format.html { render action: "new" }
        format.json { render json: @item_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /item_categories/1
  # PUT /item_categories/1.json
  def update
    @item_category = ItemCategory.find(params[:id])

    respond_to do |format|
      if @item_category.update_attributes(params[:item_category])
        format.html { redirect_to @item_category, notice: 'Item category was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @item_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_categories/1
  # DELETE /item_categories/1.json
  def destroy
    @item_category = ItemCategory.find(params[:id])
    @item_category.destroy

    respond_to do |format|
      format.html { redirect_to item_categories_url }
      format.json { head :ok }
    end
  end
end
