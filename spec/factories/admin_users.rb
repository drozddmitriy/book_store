FactoryBot.define do
  factory :admin_user do
    email { FFaker::Internet.safe_email }
    password { FFaker::Internet.password }
  end
end
