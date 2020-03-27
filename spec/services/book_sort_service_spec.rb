RSpec.describe BookSortService do
  context 'when default filter' do
    let(:book_filters_service) { described_class.new(nil) }

    it { expect(book_filters_service.sort_sym).to eq(BookSortService::SORTS.keys.first) }
  end

  context 'when filter from params' do
    let(:book_filters_service) { described_class.new(:pop_first) }

    it { expect(book_filters_service.sort_sym).to eq(BookSortService::SORTS.keys.second) }
  end
end
