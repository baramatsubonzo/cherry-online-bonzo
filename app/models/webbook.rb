class Webbook < ApplicationRecord
  has_one_attached :image

  has_many :cart_webbooks
end
