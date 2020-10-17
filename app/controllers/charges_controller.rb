class ChargesController < ApplicationController
  def new
  end
  
  def create
    @webbook = Webbook.find(params[:id])
    
    @customer_form = CustomerForm.new

    stripe

    # 購入が成功した場合の処理
    # ここに購入完了のメール通知処理を実装する
    # 履歴が作成されることを追加する
    add_purchase_history
    redirect_to webbook_path(params[:id]), notice: "商品を購入しました！"
  
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
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

  def stripe
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })
  
    charge = Stripe::Charge.create({
        customer: customer.id,
        amount: @webbook.price,
        description: "商品名: #{@webbook.title}",
        currency: 'jpy',
    })
  end
end
