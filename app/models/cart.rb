class Cart < ApplicationRecord
  belongs_to :user

  has_many :webbooks, through: :cart_webbooks
end
