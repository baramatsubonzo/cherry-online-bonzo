FactoryBot.define do
  factory :webbook do
    title { "MyString" }
    author { "MyString" }
    description { "MyText" }
    price { 1 }
    release_date { "2020-10-09" }
    release { false }
  end
end
