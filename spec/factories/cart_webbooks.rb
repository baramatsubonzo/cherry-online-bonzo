FactoryBot.define do
  factory :cart_webbook do
    cart { FactoryBot.create(:cart) }
    webbook { FactoryBot.create(:webbook) }
  end
end
