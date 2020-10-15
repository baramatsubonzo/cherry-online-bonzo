class Webbook < ApplicationRecord
  has_one_attached :image

  has_many :carts, through: :cart_webbooks
end
