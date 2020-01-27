RSpec.describe 'Checkout page', type: :feature do
  let(:user) { create(:user) }
  let(:order) { create(:order) }

  before do
    create(:book)
    create_list(:delivery, 3)
    login_as(user, scope: :user)
    visit root_path
    find('input[value="Buy Now"]').click
    find('a.shop-link.hidden-xs').click
  end

  context 'when user buy book' do
    it { expect(page).to have_current_path order_items_path, ignore_query: true }
  end

  context 'when user click login' do
    before { find('a[href="/checkout/login"]').click }

    it { expect(page).to have_current_path checkout_path(:addresses), ignore_query: true }
  end

  context 'when user fill in address form' do
    before do
      find('a[href="/checkout/login"]').click
      addresses_form
    end

    it { expect(page).to have_current_path checkout_path(:delivery), ignore_query: true }
  end

  context 'when user check delivery' do
    before do
      find('a[href="/checkout/login"]').click
      addresses_form
      all('.radio-label').first.click
      click_button(I18n.t('views.checkout.save_continue'))
    end

    it { expect(page).to have_current_path checkout_path(:payment), ignore_query: true }
  end

  context 'when user fill in credit card' do
    before { credit_card_prepare }

    it { expect(page).to have_current_path checkout_path(:confirm), ignore_query: true }
  end

  context 'when user confirm order' do
    before do
      credit_card_prepare
      click_button(I18n.t('views.checkout.place_order'))
    end

    it { expect(page).to have_current_path checkout_path(:complete), ignore_query: true }
    it { expect(page).to have_content I18n.t('views.checkout.email', email: user.email) }
  end
end
