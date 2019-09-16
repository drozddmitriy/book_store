class BookDecorator
  def initialize(book)
    @book = book
  end

  def author_full_name
    @book.authors.map { |author| author.firstname + ' ' + author.lastname }.join(", ")
  end
end
