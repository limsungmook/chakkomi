class ArticlesController < ApplicationController
  def intro
  end

  def show
    if params[:category_name].nil?
      @post = find_post_first('intro')
    else
      if params[:one_article].nil?
        @posts = find_posts_all(params[:category_name])
      else
        @post = find_post_first(params[:category_name])
        params[:one_article] = nil
      end
      params[:category_name] = nil
    end

    respond_to do |format|
      if !@post.nil? || !@posts.nil?
        format.html 
        format.js { @post }
      else
        format.html { redirect_to( :back ) }
      end
    end


  end


  protect_from_forgery
  private


  def find_posts_all(category_name)
    @category = Category.find(:first, :conditions => ["name = ?", category_name]) 
    @posts = @category.posts.paginate(:per_page => 5, :page => params[:page])
  end
  def find_post_first(category_name)
    @category = Category.find(:first, :conditions => ["name = ?", category_name]) 
    @posts = @category.posts
    @post = @posts.find(:first)
  end


end
