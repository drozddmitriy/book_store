RSpec.describe 'Settings page', type: :feature do
  let(:user) { create(:user) }
  let(:address) { build(:address) }

  before { login_as(user, scope: :user) }

  context 'when create address' do
    before do
      visit addresses_path
      within '#billing_address' do
        fill_in 'First name', with: address.first_name
        fill_in 'Last name', with: address.last_name
        fill_in 'Address', with: address.address
        fill_in 'City', with: address.city
        fill_in 'Zip', with: address.zip
        find('#address_country').find(:xpath, 'option[2]').select_option
        fill_in 'Phone', with: address.phone
        click_on('Save')
      end
    end

    it do
      expect(page).to have_current_path(addresses_path)
      expect(page).to have_content(I18n.t('controllers.addresses.address_created'))
    end
  end

  context 'when not created address' do
    before do
      visit addresses_path
      within '#billing_address' do
        find('#address_country').find(:xpath, 'option[2]').select_option
        fill_in 'Phone', with: address.phone
        click_on('Save')
      end
    end

    it do
      expect(page).to have_current_path(addresses_path)
      expect(page).to have_content(I18n.t('controllers.addresses.address_not_created'))
    end
  end

  context 'when update address' do
    let(:address) { create(:address, addressable: user) }

    before do
      address
      visit addresses_path
      within '#billing_address' do
        fill_in 'First name', with: 'update'
        click_on('Save')
      end
    end

    it do
      expect(page).to have_current_path(addresses_path)
      expect(page).to have_content(I18n.t('controllers.addresses.address_updated'))
    end
  end
end
