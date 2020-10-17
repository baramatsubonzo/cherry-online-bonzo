class CustomerForm
  include ActiveModel::Model

  validate :validate_purchase


  private

  def validate_purchase
    if current_user.purchase_history.purchase_history_webbooks.find_by(webbook_id: @webbook.id).present?
      binding.pry
      errors.add(:base, "すでに購入済みです")
    end
  end
end