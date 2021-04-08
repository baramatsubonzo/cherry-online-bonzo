FactoryBot.define do
  factory :purchase_history_webbook do
    purchase_history { purchase_history }
    webbook { webbook }
    charge_id { 'hogehoge' }
  end
end
