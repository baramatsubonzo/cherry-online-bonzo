class CartsController < ApplicationController
  def show
    @cart_webbooks = current_cart.cart_webbooks
  end
end
