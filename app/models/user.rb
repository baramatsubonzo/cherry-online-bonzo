class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_one :cart, dependent: :destroy
  has_one :purchase_history
end
