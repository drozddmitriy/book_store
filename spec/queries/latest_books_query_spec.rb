RSpec.describe LatestBooksQuery do
  subject(:latest_books) { described_class }

  let!(:book1) { create(:book) }
  let!(:book2) { create(:book) }
  let!(:book3) { create(:book) }
  let!(:book4) { create(:book) }

  it { expect(latest_books.call).to match_array([book2, book3, book4]) }
end
