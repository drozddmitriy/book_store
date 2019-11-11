FactoryBot.define do
  factory :coupon do
    coupon { 'COUPONNNNN' }
    sale { rand(1..99) }
    active { true }
  end
end
