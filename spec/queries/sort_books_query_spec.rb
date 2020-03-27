RSpec.describe SortBooksQuery do
  subject(:sort_books) { described_class }

  let!(:book1) { create(:book, title: 'America', price: 100) }
  let!(:book2) { create(:book, title: 'Bolivia', price: 200) }
  let!(:book3) { create(:book, title: 'Costa Rica', price: 300) }
  let!(:book4) { create(:book, title: 'Dominican Republic', price: 400) }

  context 'when sort by default' do
    it do
      sort = sort_books.call(Book.all, :newest)
      expect(sort).to match_array([book4, book3, book2, book1])
    end
  end

  context 'when sort by title_asc' do
    it do
      sort = sort_books.call(Book.all, :title_asc)
      expect(sort).to match_array([book1, book2, book3, book4])
    end
  end

  context 'when sort by title_desc' do
    it do
      sort = sort_books.call(Book.all, :title_desc)
      expect(sort).to match_array([book4, book3, book2, book1])
    end
  end

  context 'when sort by price_asc' do
    it do
      sort = sort_books.call(Book.all, :price_asc)
      expect(sort).to match_array([book1, book2, book3, book4])
    end
  end

  context 'when sort by price_desc' do
    it do
      sort = sort_books.call(Book.all, :price_desc)
      expect(sort).to match_array([book4, book3, book2, book1])
    end
  end

  context 'when sort by popular_first' do
    before do
      create(:order_item, book: book2)
      create(:order_item, book: book2)
      create(:order_item, book: book3)
      create(:order_item, book: book4)
    end

    it do
      sort = sort_books.call(Book.all, :popular_first)
      expect(sort).to match_array([book2, book3, book4, book1])
    end
  end
end
