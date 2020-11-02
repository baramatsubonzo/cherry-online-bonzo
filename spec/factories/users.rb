FactoryBot.define do
  factory :user do
    name { 'user_1' }
    email { 'user_1@sample.com' }
    password { "password" }
    admin { false }
  end

  factory :admin_user, class: User do
    name { '管理者' }
    email { 'admin@sample.com' }
    password { "password" }
    admin { true }
  end
end
