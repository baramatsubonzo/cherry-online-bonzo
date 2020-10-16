class PurchaseHistoryWebbook < ApplicationRecord
  belongs_to :purchase_history
  belongs_to :webbook
end
