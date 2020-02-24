RSpec.describe 'Order page', type: :feature do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:order_item) { [create(:order_item, book: book)] }
  let(:addresses) { create_list(:address, 1) }
  let(:credit_card) { create(:credit_card) }
  let(:delivery) { create(:delivery) }
  let(:order) do
    create(:order, order_items: order_item,
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

    it do
      expect(page).to have_content(I18n.t('views.checkout.order', order: order.number))
      expect(page).to have_content(order.delivery.name)
      expect(page).to have_content(order.show_credit_card)
      expect(page).to have_content(order.show_expiration_month_year)
      expect(page).to have_content(order.order_items.first.book.title)
      expect(page).to have_content(order.order_items.first.quantity)
      expect(page).to have_content(order.order_items.first.book.price)
      expect(page).to have_content(current_address.first.full_name)
      expect(page).to have_content(current_address.first.address)
      expect(page).to have_content(current_address.first.city_zip)
      expect(page).to have_content(current_address.first.country)
      expect(page).to have_content(current_address.first.phone_address)
    end
  end
end
