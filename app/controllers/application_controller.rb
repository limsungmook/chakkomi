class ApplicationController < ActionController::Base
  def intro
    @category = Category.find(:first, :conditions => "name = 'intro'")
    #  @posts = @category.posts.all
    @posts = @category.posts
    @post = @posts.find(:first)
  end
  
  def history
    @category = Category.find(:first, :conditions => "name = 'history'")
    #  @posts = @category.posts.all
    @posts = @category.posts
    @post = @posts.find(:first)
  end
  
  def artmull
    @category = Category.find(:first, :conditions => "name = 'artmull'")
    #  @posts = @category.posts.all
    @posts = @category.posts
  end
  
  protect_from_forgery

  private
  
  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
