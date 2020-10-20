class ChargesController < ApplicationController
  before_action :prevent_duouble_purchase, only: [:create]

  def new
  end
  
  def create
    @webbook = Webbook.find(params[:id])

    @stripe_form = StripeForm.new(params[:stripeEmail], params[:stripeToken], @webbook)
    @stripe_form.save!

    # 購入が成功した場合の処理
    # ここに購入完了のメール通知処理を実装する
    # 履歴が作成されることを追加する
    add_purchase_history

    PurchaseMailer.creation_email(current_user).deliver_now
    redirect_to webbook_path(params[:id]), notice: "商品を購入しました！"
  end

  private

  def add_purchase_history
    if @purchase_history_webbooks.blank?
      # RFC: この渡し方で本当にいいのか？
      @purchase_history_webbook = current_user.purchase_history.purchase_history_webbooks.build(purchase_history_id: params[:purchase_history_id], webbook_id: @webbook.id)
    end
    @purchase_history_webbook.save
    # todo: 後でわかりやすく変更する
    # redirect_to current_cart
  end

  def prevent_duouble_purchase
    redirect_to root_path, notice: "すでに購入済みの商品です" if user_has_book?
  end

  def user_has_book?
    @webbook = Webbook.find(params[:id])
    current_user.purchase_history
                .purchase_history_webbooks
                .find_by(webbook_id: @webbook.id)
                .present?
  end
end
