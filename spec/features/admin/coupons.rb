require 'rails_helper'

RSpec.describe 'Admin Coupons' do
  let(:code) { '1234567890' }

  before do
    create(:coupon)

    admin_user = create(:admin_user)
    login_as(admin_user, scope: :admin_user)

    visit admin_coupons_path
  end

  it 'Admin can create Coupon' do
    click_link('New Coupon')
    fill_in 'coupon[coupon]', with: code
    find(:css, '#coupon_active').set(true)
    fill_in 'coupon[sale]', with: 15.0
    click_button('Create Coupon')

    expect(page).to have_content(code)
    expect(page).to have_content(15.0)
  end

  it 'Admin can edit Coupon' do
    click_link('Edit', match: :first)

    expect(page).to have_current_path(edit_admin_coupon_path(Coupon.last))

    fill_in 'coupon[coupon]', with: code
    find(:css, '#coupon_active').set(false)
    fill_in 'coupon[sale]', with: 20.0
    click_button('Update Coupon')

    expect(page).to have_content(code)
    expect(page).to have_content(20.0)
  end
end
