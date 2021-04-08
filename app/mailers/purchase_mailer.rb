class PurchaseMailer < ApplicationMailer
  default from: 'cherryonline_bonzo@sample.com'
  def creation_email(user)
    @user = user
    mail(
      subject: '購入完了メール',
      to: user.email,
      from: 'cherryonline_bonzo@sample.com'
    )
  end
end
