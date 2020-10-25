class CartWebbook < ApplicationRecord
  # TODO: 同じ商品をカートに入れられないようにする制限が必要。このやり方だと、別のユーザーの場合でもカートに商品を入れられなくなる
  # validates :webbook, uniqueness: true
  
  belongs_to :cart
  belongs_to :webbook
end
