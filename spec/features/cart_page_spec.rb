RSpec.describe 'Cart page', type: :feature do
  let!(:book) { create(:book) }

  context 'when add book to cart' do
    before do
      visit root_path
      click_button('Buy Now')
      find('a.shop-link.pull-right').click
    end

    it do
      expect(page).to have_current_path order_items_path, ignore_query: true
      expect(page).to have_content(book.title)
      expect(page).to have_content(book.price)
    end
  end

  context 'when coupon valid' do
    let(:sale) { create(:coupon) }

    before do
      visit order_items_path
      fill_in 'coupon', with: sale.coupon
      click_on('Apply Coupon')
    end

    it { expect(page).to have_content(I18n.t('controllers.coupons.coupon_applied')) }
  end

  context 'when coupon invalid' do
    before do
      visit order_items_path
      fill_in 'coupon', with: 'invalid coupon'
      click_on('Apply Coupon')
    end

    it { expect(page).to have_content(I18n.t('controllers.coupons.coupon_not_applied')) }
  end
end
