FactoryBot.define do
  factory :user do
    name { 'テスト太郎' }
    email { 'test1@sample.com' }
    password { "password" }
  end

  factory :admin_user, class: User do
    name { '管理者' }
    email { 'admin@sample.com' }
    password { "password" }
    admin { true }
  end
end
