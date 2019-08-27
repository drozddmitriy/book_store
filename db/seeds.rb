# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

['Mobile development', 'Photo', 'Web development', 'Web design'].each do |category|
  Category.create(title: category)
end

10.times do
  Author.create(firstname: FFaker::Name.first_name,
                lastname: FFaker::Name.last_name,
                biography: FFaker::Lorem.paragraph)
end

categories = Category.all

10.times do |index|
  Book.create(title: FFaker::Book.title,
              price: rand(1..99),
              description: FFaker::Lorem.paragraphs.join('. ') + FFaker::Lorem.paragraphs.join('. '),
              quantity: rand(0...20),
              dimension_h: rand(5.5...10.5).floor(2),
              dimension_w: rand(4.5...5.5).floor(2),
              dimension_d: rand(1.3...4.5).floor(2),
              year: rand(2001..2019),
              material: FFaker::Lorem.words.join(', '),
              category_id: categories.sample.id)
end
