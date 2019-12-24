require 'rails_helper'

RSpec.describe 'Admin Orders', type: :feature do
  let(:admin_user) { create(:admin_user) }

  before do
    create(:order)
    login_as(admin_user, scope: :admin_user)
    visit admin_orders_path
  end

  context 'when admin update status' do
    before do
      click_link('Edit', match: :first)

      select('order_in_delivery', from: 'order[active_admin_requested_event]')
      click_button('Update Order')
    end

    it { expect(page).to have_content('in_delivery') }
  end
end
