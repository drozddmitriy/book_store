FactoryBot.define do
  factory :admin_user do
    email { 'mail@gmail.com' }
    password { FFaker::Internet.password }
  end
end
