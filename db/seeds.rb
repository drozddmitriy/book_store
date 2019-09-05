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

books = Book.all
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
    AuthorsBook.create(book_id: book.id,
                      author_id: author.id)
  end
end
