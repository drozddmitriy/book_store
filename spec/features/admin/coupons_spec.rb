RSpec.describe Coupon do
  let(:code) { '1234567890' }
  let(:edit_code) { '3334567991' }

  before do
    create(:coupon)

    admin_user = create(:admin_user)
    login_as(admin_user, scope: :admin_user)

    visit admin_coupons_path
  end

  context 'when admin create Coupon' do
    before do
      click_link('New Coupon')
      fill_in 'coupon[coupon]', with: code
      find(:css, '#coupon_active').set(true)
      fill_in 'coupon[sale]', with: 15.0
      click_button('Create Coupon')
    end

    it do
      expect(page).to have_content(code)
      expect(page).to have_content(15.0)
    end
  end

  context 'when admin click edit' do
    before { click_link('Edit', match: :first) }

    it { expect(page).to have_current_path(edit_admin_coupon_path(described_class.last)) }
  end

  context 'when admin edit Coupon' do
    before do
      click_link('Edit', match: :first)
      fill_in 'coupon[coupon]', with: edit_code
      find(:css, '#coupon_active').set(false)
      fill_in 'coupon[sale]', with: 20.0
      click_button('Update Coupon')
    end

    it do
      expect(page).to have_content(edit_code)
      expect(page).to have_content(20.0)
    end
  end
end
