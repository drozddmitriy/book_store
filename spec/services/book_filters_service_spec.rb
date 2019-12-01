require 'rails_helper'

RSpec.describe BookFiltersService do
  subject(:book_filters_service) { described_class }

  context 'when default filter' do
    it { expect(book_filters_service.filter(nil)).to eq(Book::FILTERS.first) }
  end

  context 'when filter from params' do
    it { expect(book_filters_service.filter(:popular_first)).to eq(Book::FILTERS.second) }
  end
end
