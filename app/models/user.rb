class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true

  has_one :cart, dependent: :destroy
  # FYI: ユーザーを削除しても、ユーザーの購買履歴は残したい
  has_one :purchase_history
end
