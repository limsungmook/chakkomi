class ApplicationController < ActionController::Base
  def intro
    @post = find_post_first('intro')
  end
  def info
    @posts = find_posts_all('notice')
  end
  def chakkomi
    @posts = find_posts_all('chakkomi')
  end
  def project
    @posts = find_posts_all('project')
  end
  def comics
    @posts = find_posts_all('comics')
  end
  def artmull
    @posts = find_posts_all('artmull')
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
  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
