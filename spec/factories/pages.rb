FactoryBot.define do
  factory :page do
    title { '最初の頁です' }
    content { '最高のコンテンツ' }
    webbook { FactoryBot.create(:webbook) }
    page_number { 1 }
  end
end
