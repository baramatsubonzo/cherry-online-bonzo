class Webbook < ApplicationRecord
  has_one_attached :image

  has_many :pages, dependent: :destroy
  has_many :cart_webbooks, dependent: :destroy
  has_many :purchase_history_webbooks, dependent: :destroy
  has_many :purchase_history, through: :purchase_history_webbooks
end
