class AddWebbookRequestsController < ApplicationController
  before_action :prevent_add_cart, only: [:create]

  def create
    @cart_webbook = current_user
                      .cart
                      .cart_webbooks
                      .build(webbook_id: params[:webbook_id]) if @cart_webbooks.blank?

    @cart_webbook.save

    redirect_to current_cart
  end

  def destroy
    cart_webbook = current_user
                    .cart
                    .cart_webbooks
                    .find_by(webbook_id: params[:webbook_id])
    cart_webbook.destroy
    redirect_to current_cart
  end

  def prevent_add_cart
    redirect_to root_path, notice: 'すでにカートにある商品です' if cart_has_book?
  end

  def cart_has_book?
    current_user.cart
                .cart_webbooks
                .find_by(webbook_id: params[:webbook_id])
                .present?
  end
end
