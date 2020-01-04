require 'rails_helper'

RSpec.describe OrderDecorator do
  subject(:decorator) { described_class.new(order) }

  let(:book) { create(:book) }
  let(:credit_card) { create(:credit_card) }
  let(:order_item) { [create(:order_item, book: book)] }
  let(:user) { create(:user) }
  let(:order) { create(:order, user: user, order_items: order_item, credit_card: credit_card) }
  let(:date) { order.created_at.strftime('%d/%m/%y') }
  let(:total_price) { order.order_items.map { |item| item.book.price * item.quantity }.sum }
  let(:show_expiration_month_year) { order.credit_card.expiration_month_year }
  let(:date_complete) { order.completed_at.strftime('%B %-d, %Y') }

  describe '#date' do
    it { expect(decorator.date).to eq(date) }
  end

  describe '#total_price' do
    it { expect(decorator.total_price).to eq(total_price) }
  end

  describe '#discount' do
    it { expect(decorator.discount).to eq(0) }
  end

  describe '#total_order_price' do
    it { expect(decorator.total_order_price).to eq(total_price) }
  end

  describe '#show_expiration_month_year' do
    it { expect(decorator.show_expiration_month_year).to eq(show_expiration_month_year) }
  end

  describe '#date_complete' do
    it do
      order.set_completed_at
      expect(decorator.date_complete).to eq(date_complete)
    end
  end
end
