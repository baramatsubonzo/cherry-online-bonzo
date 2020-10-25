# class PurchaseHistoriesController < ApplicationController
#   def add_purchase_history
#     if @purchase_history_webbooks.blank?
#       @purchase_history_webbook = current_user.purchase_history.purchase_history_webbooks.build(purchase_history_id: params[:purchase_history_id])
#     end

#     @cart_webbook.save
#     # todo: 後でわかりやすく変更する
#     # redirect_to current_cart
#   end
# end
