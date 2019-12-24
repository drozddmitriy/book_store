Delivery.create(name: 'FedEx', time: '1', price:  30.00)
Delivery.create(name: 'UPS', time: '2', price: 20.00)
Delivery.create(name: 'DHL', time: '3', price: 10.00)

['Mobile development', 'Photo', 'Web development', 'Web design'].each do |category|
  Category.create(title: category)
end

10.times do
  Author.create(first_name: FFaker::Name.first_name,
                last_name: FFaker::Name.last_name,
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

books = Book.all
users = User.all
authors = Author.all

def book_authors(authors)
  array = []
  rand(1..3).times do
    author = authors.sample
    array << author unless array.include?(author)
  end
  array
end

books.each do |book|
  book_authors(authors).each do |author|
    AuthorsBook.create(book_id: book.id, author_id: author.id)
  end
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

books.each do |book|
  rand(1..4).times do
    Review.create(title: FFaker::Lorem.word,
                  comment: FFaker::Lorem.sentences.join('. '),
                  rating: rand(1..5),
                  publish: true,
                  book_id: book.id,
                  user_id: users.sample.id)
  end
end
