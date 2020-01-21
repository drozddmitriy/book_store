require 'rails_helper'

RSpec.describe 'Orders page', type: :feature do
  let(:user) { create(:user) }
  let!(:order) { create(:order, user: user).decorate }

  context 'when user see orders' do
    before do
      login_as(user, scope: :user)
      visit orders_path
    end

    it { expect(page).to have_content(order.number) }
    it { expect(page).to have_content(I18n.l(order.created_at, format: :date)) }
    it { expect(page).to have_content(order.status_capitalize) }
    it { expect(page).to have_content(order.total_price) }
  end
end
