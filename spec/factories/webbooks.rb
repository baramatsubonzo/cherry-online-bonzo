FactoryBot.define do
  factory :webbook do
    title { "最初の本" }
    author { "山田　太郎" }
    description { "こんな内容の本です。" }
    price { 1000 }
    release_date { "2020-10-09" }
    release { true }
  end
end
