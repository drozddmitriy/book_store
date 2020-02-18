RSpec.describe LatestBooksQuery do
  subject(:latest_books) { described_class }

  let!(:book1) { create(:book) }
  let!(:book2) { create(:book) }
  let!(:book3) { create(:book) }
  let!(:book4) { create(:book) }

  context 'when present latest_books' do
    it { expect(latest_books.call.count).to eq(3) }
    it { expect(latest_books.call).not_to be_empty }
    it { expect(latest_books.call).to match_array([book2, book3, book4]) }
  end

  context 'when not include in latest_books' do
    it { expect(latest_books.call).not_to include(book1) }
  end
end
