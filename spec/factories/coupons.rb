FactoryBot.define do
  factory :coupon do
    coupon { 'COUPON' }
    sale { rand(1..99) }
    active { true }
  end
end
