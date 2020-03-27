FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password              { 'Passw0rd' }
    password_confirmation { 'Passw0rd' }
    confirmed_at          { Time.zone.now }
  end
end
