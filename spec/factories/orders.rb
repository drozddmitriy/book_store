FactoryBot.define do
  factory :order do
    number { Array.new(6) { Array('A'..'Z').sample }.join }
    total_price { rand(1..1000) }
    status { 'in_queue' }
    use_billing { true }
    association :user
  end
end
