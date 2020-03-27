FactoryBot.define do
  factory :coupon do
    coupon { '4259253464' }
    sale { rand(1..99) }
    active { true }
  end
end
