FactoryBot.define do
  factory :book do
    title { FFaker::Book.title }
    price { rand(1..99) }
    description { FFaker::Book.description }
    quantity { rand(0...20) }
    dimension_h { rand(5.5...10.5).floor(2) }
    dimension_w { rand(4.5...5.5).floor(2) }
    dimension_d { rand(1.3...4.5).floor(2) }
    year { rand(2001..2019) }
    material { FFaker::Lorem.words.join(', ') }
    images { [File.open(File.join(Rails.root, 'app/assets/images/test.jpg'))] }
    category
  end
end
