class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :current_cart
  # before_action :login_required

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_cart
    if session[:cart_id]
      @cart = Cart.find(session[:cart_id])
    else
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end

  # def login_required
  #   redirect_to users_login_path unless current_user
  # end
end
