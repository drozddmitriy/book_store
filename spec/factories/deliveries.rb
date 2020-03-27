FactoryBot.define do
  factory :delivery do
    sequence(:name) { |i| "Delivery#{i}" }
    time { rand(1..3) }
    price { rand(1..1000) }
  end
end
