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

  helper_method :current_user
  helper_method :user_signed_in?
  
  private
  
  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  def current_user  
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]  
  end
  
  def user_signed_in?
    return 1 if current_user 
  end
  
  def authenticate_user!
    if !current_user
      flash[:error] = 'You need to sign in before accessing this page!'
      redirect_to signin_services_path
    end
  end    
  
  
  
end
