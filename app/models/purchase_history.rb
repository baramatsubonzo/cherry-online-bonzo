class PurchaseHistory < ApplicationRecord
  belongs_to :user

  has_many :purchase_history_webbooks
end
