RSpec.describe BestSellersQuery do
  subject(:best_sellers) { described_class }

  context 'when present best_sellers' do
    let(:category1) { create(:category) }
    let(:category2) { create(:category) }

    let(:book1) { create(:book, category: category1) }
    let(:book2) { create(:book, category: category1) }
    let(:book3) { create(:book, category: category2) }
    let(:book4) { create(:book, category: category2) }

    let(:order) { create(:order, status: :delivered) }

    before do
      create(:order_item, quantity: 3, book: book1, order: order)
      create(:order_item, quantity: 1, book: book2, order: order)
      create(:order_item, quantity: 1, book: book2, order: order)
      create(:order_item, quantity: 3, book: book3, order: order)
      create(:order_item, quantity: 2, book: book4, order: order)
      create(:order_item, quantity: 2, book: book4, order: order)
    end

    it { expect(best_sellers.call).to match_array([book1, book4]) }
  end

  context 'when not include in best_sellers' do
    let(:book5) { create(:book) }

    it { expect(best_sellers.call).to be_empty }
    it { expect(best_sellers.call).not_to include(book5) }
  end
end
