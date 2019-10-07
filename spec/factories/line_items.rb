FactoryBot.define do
  factory :line_item do
    quantity { rand(1..10) }
    association :order
    association :book
  end
end
