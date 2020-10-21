class Webbook < ApplicationRecord
  has_one_attached :image

  has_many :pages, dependent: :destroy

  has_many :cart_webbooks
  has_many :purchase_history_webbooks
end
