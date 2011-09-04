class ApplicationController < ActionController::Base
  include RedirectBack
  helper_method :resource_class

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

  def current_user
    super || NilUser.new
  end

  def user_signed_in?
    !current_user.nil?
  end  
end
