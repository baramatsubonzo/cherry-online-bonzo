FactoryBot.define do
  factory :user do
    name { 'テスト太郎' }
    email { 'test1@sample.com' }
    password_digest { "password" }
  end
end
