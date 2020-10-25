class StripeForm
  include ActiveModel::Model

  attr_accessor :email, :source, :user, :charge

  def initialize(email, source, webbook)
    @email = email
    @source = source
    @webbook = webbook
  end

  def save!
    customer = Stripe::Customer.create({
      email: @email,
      source: @source,
    })
  
    @charge = Stripe::Charge.create({
        customer: customer.id,
        amount: @webbook.price,
        description: "商品名: #{@webbook.title}",
        currency: 'jpy',
    })

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end