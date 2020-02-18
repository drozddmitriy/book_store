RSpec.describe BookSortService do
  context 'when default filter' do
    let(:book_filters_service) { described_class.new(nil) }

    it { expect(book_filters_service.filter_sym).to eq(BookSortService::MENU_SORTS.first) }
  end

  context 'when filter from params' do
    let(:book_filters_service) { described_class.new(:popular_first) }

    it { expect(book_filters_service.filter_sym).to eq(BookSortService::MENU_SORTS.second) }
  end
end
