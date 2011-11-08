class WallpapersController < ApplicationController
#  load_and_authorize_resource
  def index
    if !params[:year].nil?
      @year = params[:year]
    else
      @wallpaper = Wallpaper.find(:first, :order => "year desc")
      @year = @wallpaper.year
    end
    @years = Wallpaper.find(:all, :select => 'DISTINCT year', :order => "year desc")
    @wallpapers = Wallpaper.find(:all, :conditions => ["year = ?", @year], :order => "month desc")
    
    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.xml  { render :xml => @wallpapers }
    end
  end
  def show
    @wallpaper = Wallpaper.find(params[:id])
  end

  # GET /wallpapers/new
  # GET /wallpapers/new.xml
  def new
    @wallpaper = Wallpaper.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @wallpaper }
    end
  end
  
  # GET /wallpapers/1/edit
  def edit
    @wallpaper = Wallpaper.find(params[:id])
  end
  
  # POST /wallpapers
  # POST /wallpapers.xml
  def create
    @wallpaper = Wallpaper.new(params[:wallpaper])
    
    respond_to do |format|
      if @wallpaper.save
        format.html { redirect_to(@wallpaper, :notice => 'Wallpaper was successfully created.') }
        format.xml  { render :xml => @wallpaper, :status => :created, :location => @wallpaper }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @wallpaper.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /wallpapers/1
  # PUT /wallpapers/1.xml
  def update
    @wallpaper = Wallpaper.find(params[:id])
    
    respond_to do |format|
      if @wallpaper.update_attributes(params[:wallpaper])
        format.html { redirect_to(@wallpaper, :notice => 'Wallpaper was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @wallpaper.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /wallpapers/1
  # DELETE /wallpapers/1.xml
  def destroy
    @wallpaper = Wallpaper.find(params[:id])
    @wallpaper.destroy
    
    respond_to do |format|
      format.html { redirect_to(wallpapers_url) }
      format.xml  { head :ok }
    end
  end
  
end
