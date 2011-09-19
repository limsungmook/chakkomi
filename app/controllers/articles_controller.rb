class ArticlesController < ApplicationController
  def show
    if params[:category_name].nil?
      @post = find_post_first('intro')
    else
      if params[:one_article].nil?
        @posts = find_posts_all(params[:category_name])
      else
        @post = find_post_first(params[:category_name])
      end
      params[:category_name] = nil
    end
  end


  protect_from_forgery
  private


  def find_posts_all(category_name)
    @category = Category.find(:first, :conditions => ["name = ?", category_name]) 
    @posts = @category.posts
  end
  def find_post_first(category_name)
    @category = Category.find(:first, :conditions => ["name = ?", category_name]) 
    @posts = @category.posts
    @post = @posts.find(:first)
  end


end
