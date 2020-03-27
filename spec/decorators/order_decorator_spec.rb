RSpec.describe OrderDecorator do
  subject(:decorator) { described_class.new(order) }

  let(:book) { create(:book, price: 100) }
  let(:credit_card) { create(:credit_card) }
  let(:order_item) { [create(:order_item, book: book, quantity: 2)] }
  let(:user) { create(:user) }
  let(:order) { create(:order, user: user, order_items: order_item, credit_card: credit_card) }

  describe '#total_price' do
    let(:test_price) { 200 }

    it { expect(decorator.total_price).to eq(test_price) }
  end

  describe '#discount' do
    let(:coupon) { create(:coupon, sale: 10) }

    it { expect(decorator.discount).to eq(0) }

    it do
      coupon.update(order_id: order.id)
      expect(decorator.discount).to eq(20)
    end
  end

  describe '#total_order_price' do
    let(:test_price) { 200 }

    it { expect(decorator.total_order_price).to eq(test_price) }
  end

  describe '#show_expiration_month_year' do
    let(:test_month_year) { '11/19' }

    it { expect(decorator.show_expiration_month_year).to eq(test_month_year) }
  end
end
