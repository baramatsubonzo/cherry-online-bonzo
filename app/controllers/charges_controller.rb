class ChargesController < ApplicationController
  def new
  end
  
  def create
    @webbook = Webbook.find(params[:id])

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

    # 購入が成功した場合の処理
    # ここに購入完了のメール通知処理を実装する
    redirect_to webbook_path(params[:id]), notice: "商品を購入しました！"
  
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
