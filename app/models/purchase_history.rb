class PurchaseHistory < ApplicationRecord
  belongs_to :user

  has_many :purchase_history_webbooks
  has_many :webbooks, through: :purchase_history_webbooks
end
