class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :current_cart
  include SessionsHelper
  before_action :login_required

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_cart
    @current_cart = Cart.find_by(user_id: current_user.id)
  end

  def login_required
    redirect_to login_path unless current_user
  end

  def user_has_book?
    @webbook = Webbook.find(params[:id])
    current_user.purchase_history
      .purchase_history_webbooks
      .find_by(webbook_id: @webbook.id)
      .present?
  end
end
