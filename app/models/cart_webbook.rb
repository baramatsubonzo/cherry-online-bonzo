class CartWebbook < ApplicationRecord
  validates :webbook, uniqueness: true
  
  belongs_to :cart
  belongs_to :webbook
end
