RSpec.describe 'Orders page', type: :feature do
  let(:user) { create(:user) }
  let!(:order) { create(:order, user: user).decorate }

  context 'when user see orders' do
    before do
      login_as(user, scope: :user)
      visit orders_path
    end

    it do
      expect(page).to have_content(order.number)
      expect(page).to have_content(I18n.l(order.created_at, format: :date))
      expect(page).to have_content(order.status_capitalize)
      expect(page).to have_content(order.total_price)
    end
  end
end
