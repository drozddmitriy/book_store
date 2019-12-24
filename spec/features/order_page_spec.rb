require 'rails_helper'

RSpec.describe 'Order page', type: :feature do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:line_item) { [create(:line_item, book: book)] }
  let(:addresses) { [create(:address)] }
  let(:credit_card) { create(:credit_card) }
  let(:delivery) { create(:delivery) }
  let(:order) do
    create(:order, line_items: line_item,
                   addresses: addresses,
                   delivery: delivery,
                   credit_card: credit_card,
                   user: user).decorate
  end
  let(:current_address) { OrderAddressesDecorator.decorate_collection(order.addresses) }

  context 'when user see detaile information for order' do
    before do
      login_as(user, scope: :user)
      visit order_path(order)
    end

    it { expect(page).to have_content(I18n.t('views.checkout.order', order: order.number)) }
    it { expect(page).to have_content(order.delivery.name) }
    it { expect(page).to have_content(order.show_credit_card) }
    it { expect(page).to have_content(order.show_expiration_month_year) }
    it { expect(page).to have_content(order.line_items.first.book.title) }
    it { expect(page).to have_content(order.line_items.first.quantity) }
    it { expect(page).to have_content(order.line_items.first.book.price) }
    it { expect(page).to have_content(current_address.first.full_name) }
    it { expect(page).to have_content(current_address.first.address) }
    it { expect(page).to have_content(current_address.first.city_zip) }
    it { expect(page).to have_content(current_address.first.country) }
    it { expect(page).to have_content(current_address.first.phone_address) }
  end
end
