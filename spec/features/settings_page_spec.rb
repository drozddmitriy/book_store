require 'rails_helper'

RSpec.describe 'Settings page', type: :feature do
  let(:user) { create(:user) }
  # let!(:address_update) { create(:address) }
  let(:address) { build(:address) }

  before do
    login_as(user, scope: :user)
    visit addresses_path
  end

  context 'when create address' do
    before do
      within '#billing_address' do
        fill_in 'Firstname', with: address.firstname
        fill_in 'Lastname', with: address.lastname
        fill_in 'Address', with: address.address
        fill_in 'City', with: address.city
        fill_in 'Zip', with: address.zip
        find('#address_country').find(:xpath, 'option[2]').select_option
        fill_in 'Phone', with: address.phone
        click_on('Save')
      end
    end

    it { expect(page).to have_current_path(addresses_path) }
    it { expect(page).to have_content(I18n.t('controllers.addresses.address_created')) }
  end

  context 'when not created address' do
    before do
      within '#billing_address' do
        fill_in 'Firstname', with: ''
        fill_in 'Lastname', with: ''
        fill_in 'Address', with: ''
        fill_in 'City', with: ''
        fill_in 'Zip', with: address.zip
        find('#address_country').find(:xpath, 'option[2]').select_option
        fill_in 'Phone', with: address.phone
        click_on('Save')
      end
    end

    it { expect(page).to have_current_path(addresses_path) }
    it { expect(page).to have_content(I18n.t('controllers.addresses.address_not_created')) }
  end

  # context 'when update address' do
  #   before do
  #       within '#billing_address' do
  #         fill_in 'Firstname', with: address_update.firstname + 'update'
  #         fill_in 'Lastname', with: address_update.lastname
  #         fill_in 'Address', with: address_update.address
  #         fill_in 'City', with: address_update.city
  #         fill_in 'Zip', with: address_update.zip
  #         find('#address_country').find(:xpath, 'option[2]').select_option
  #         fill_in 'Phone', with: address_update.phone
  #         click_on('Save')
  #       end
  #     end
  #
  #     it { expect(page).to have_current_path(addresses_path) }
  #     it { expect(page).to have_content(I18n.t('controllers.addresses.address_updated')) }
  # end
end
