class PurchaseHistoryWebbook < ApplicationRecord
  belongs_to :purchase_history
  belongs_to :webbook

  def add_purchase_history(current_user, purchase_history_id, webbook_id, charge_id)
    if @purchase_history_webbooks.blank?

      @purchase_history_webbook = current_user
                                  .purchase_history
                                  .purchase_history_webbooks
                                  .build(purchase_history_id: purchase_history_id, webbook_id: webbook_id, charge_id: charge_id)
    end

    @purchase_history_webbook.save
  end
end
