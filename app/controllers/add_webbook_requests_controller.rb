class AddWebbookRequestsController < ApplicationController
  def create
    if @cart_webbooks.blank?
      @cart_webbook = current_user.cart.cart_webbooks.build(webbook_id: params[:webbook_id])
    end

    @cart_webbook.save

    redirect_to current_cart
  end

  def destroy
    cart_webbook = current_user.cart.cart_webbooks.find_by(webbook_id: params[:webbook_id])
    cart_webbook.destroy
    redirect_to current_cart
  end
end
