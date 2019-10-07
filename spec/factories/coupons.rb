FactoryBot.define do
  factory :coupon do
    # coupon { Array.new(6){ Array('A'..'Z').sample }.join }
    coupon { 'COUPON' }
    sale { rand(1..99) }
    active { true }
  end
end
