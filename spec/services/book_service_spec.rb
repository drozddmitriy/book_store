RSpec.describe BookService do
  subject(:book_service) { described_class }

  let(:category) { create(:category) }
  let!(:book_by_category) { create(:book, title: 'Aiybolit', category_id: category.id) }
  let!(:book) { create(:book, title: 'Noname') }
  let(:filter) { :title_desc }

  context 'with category title' do
    it { expect(book_service.new(category).category_title).to eq(category.title) }
  end

  context 'when select category' do
    it { expect(book_service.new(category.id, filter).sort_for_books.first).to eq(book_by_category) }
  end

  context 'when not select category' do
    it { expect(book_service.new(nil, filter).sort_for_books.first).to eq(book) }
  end
end
