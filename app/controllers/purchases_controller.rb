class PurchasesController < ApplicationController
  before_action :prevent_duouble_purchase, only: [:create]
  before_action :release_date_came?, only: [:create]
  before_action :set_webbook

  def create

    @stripe_form = StripeForm.new(params[:stripeEmail], params[:stripeToken], @webbook)
    @stripe_form.save!

    @purchase_history_webbooks = PurchaseHistoryWebbook.new
    @purchase_history_webbooks.add_purchase_history(current_user, params[:purchase_history_id], @webbook.id, @stripe_form.charge[:id])

    PurchaseMailer.creation_email(current_user).deliver_now
    redirect_to mypage_path, notice: '商品を購入しました！'
  end

  private

  def set_webbook
    @webbook = Webbook.find(params[:id])
  end

  def prevent_duouble_purchase
    redirect_to root_path, notice: 'すでに購入済みの商品です' if user_has_book?
  end

  def user_has_book?
    current_user.purchase_history
                .purchase_history_webbooks
                .find_by(webbook_id: params[:id])
                .present?
  end

  def release_date_came?
    redirect_to root_path, notice: '発売日前の商品です' if @webbook.release_date > Date.today
  end
end
