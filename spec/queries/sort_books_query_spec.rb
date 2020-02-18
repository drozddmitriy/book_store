RSpec.describe SortBooksQuery do
  subject(:sort_books) { described_class }

  let!(:book1) { create(:book, title: 'America', price: 100) }
  let!(:book2) { create(:book, title: 'Bolivia', price: 200) }
  let!(:book3) { create(:book, title: 'Costa Rica', price: 300) }
  let!(:book4) { create(:book, title: 'Dominican Republic', price: 400) }

  context 'when sort by default' do
    it do
      sort = sort_books.new(Book.all).by_sort(:newest).first
      expect(sort).to eq(book4)
    end
  end

  context 'when sort by title_asc' do
    it do
      sort = sort_books.new(Book.all).by_sort(:title_asc).first
      expect(sort).to eq(book1)
    end
  end

  context 'when sort by title_desc' do
    it do
      sort = sort_books.new(Book.all).by_sort(:title_desc).first
      expect(sort).to eq(book4)
    end
  end

  context 'when sort by price_asc' do
    it do
      sort = sort_books.new(Book.all).by_sort(:price_asc).first
      expect(sort).to eq(book1)
    end
  end

  context 'when sort by price_desc' do
    it do
      sort = sort_books.new(Book.all).by_sort(:price_desc).first
      expect(sort).to eq(book4)
    end
  end

  context 'when sort by popular_first' do
    before do
      create(:order_item, book: book2)
      create(:order_item, book: book2)
      create(:order_item, book: book3)
      create(:order_item, book: book4)
    end

    it 'return book with order' do
      sort = sort_books.new(Book.all).by_sort(:popular_first).first
      expect(sort).to eq(book2)
    end

    it 'return book without order' do
      sort = sort_books.new(Book.all).by_sort(:popular_first).last
      expect(sort).to eq(book1)
    end
  end
end
