class ApplicationController < ActionController::Base

  WillPaginate.per_page = 2

  protect_from_forgery

  private

  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  def after_sign_in_path_for(resource)
    session[:back_url] || '/articles/intro'
  end

end
