RSpec.describe BookDecorator do
  subject(:decorator) { described_class.new(book) }

  let(:authors) { create_list(:author, 1) }
  let(:book) { create(:book, authors: authors) }

  describe '#book_dimensions' do
    let(:book_dimensions) { "H: #{book.dimension_h} x W: #{book.dimension_w} x D: #{book.dimension_d}" }

    it { expect(decorator.book_dimensions).to eq(book_dimensions) }
  end

  describe '#book_reviews' do
    it { expect(decorator.book_reviews).to eq(0) }
  end

  describe '#author_full_name' do
    let(:author_test) { AuthorDecorator.new(authors.first) }

    it { expect(decorator.author_full_name).to eq(author_test.full_name) }
  end
end
