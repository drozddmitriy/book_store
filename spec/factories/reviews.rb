FactoryBot.define do
  factory :review do
    rating { rand(1..5) }
    title { FFaker::Lorem.word }
    comment { FFaker::Lorem.sentences.join('. ') }
    association :book
    association :user
  end
end
