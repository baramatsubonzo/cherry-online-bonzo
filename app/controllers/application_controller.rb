class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :current_cart
  include SessionsHelper
  # before_action :login_required

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_cart
    @current_cart = Cart.find_by(user_id: current_user.id)
  end

  # def login_required
  #   redirect_to users_login_path unless current_user
  # end
end
