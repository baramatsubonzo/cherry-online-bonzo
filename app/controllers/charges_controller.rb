class ChargesController < ApplicationController
  before_action :prevent_duouble_purchase, only: [:create]

  def new
  end
  
  def create
    @webbook = Webbook.find(params[:id])

    @stripe_form = StripeForm.new(params[:stripeEmail], params[:stripeToken], @webbook)
    @stripe_form.save!

    @purchase_history_webbooks = PurchaseHistoryWebbook.new
    @purchase_history_webbooks.add_purchase_history(current_user, params[:purchase_history_id], @webbook.id)

    PurchaseMailer.creation_email(current_user).deliver_now
    redirect_to webbook_path(params[:id]), notice: "商品を購入しました！"
  end

  private

  def prevent_duouble_purchase
    redirect_to root_path, notice: "すでに購入済みの商品です" if user_has_book?
  end

  def user_has_book?
    current_user.purchase_history
      .purchase_history_webbooks
      .find_by(webbook_id: params[:id])
      .present?
  end
end
