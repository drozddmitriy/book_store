require 'rails_helper'

RSpec.describe BookFiltersService do
  context 'when default filter' do
    let(:book_filters_service) { described_class.new(nil) }

    it { expect(book_filters_service.filter_sym).to eq(BookFiltersService::FILTERS.first) }
  end

  context 'when filter from params' do
    let(:book_filters_service) { described_class.new(:popular_first) }

    it { expect(book_filters_service.filter_sym).to eq(BookFiltersService::FILTERS.second) }
  end
end
