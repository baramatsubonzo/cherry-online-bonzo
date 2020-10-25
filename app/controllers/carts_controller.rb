class CartsController < ApplicationController
  def show
    @cart_webbooks = current_cart.cart_webbooks
  end

  def add_webbook
    if @cart_webbooks.blank?
      @cart_webbook = current_user.cart.cart_webbooks.build(webbook_id: params[:webbook_id])
    end

    @cart_webbook.save
    # todo: 後でわかりやすく変更する
    redirect_to current_cart
  end

  def delete_webbook
    @cart_webbook = current_user.cart.cart_webbooks.find_by(webbook_id: params[:webbook_id])
    @cart_webbook.destroy
    redirect_to current_cart
  end
end
