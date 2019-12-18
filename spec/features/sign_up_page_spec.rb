require 'rails_helper'

RSpec.describe 'Registration', type: :feature do
  let!(:user) { create(:user) }

  before { visit new_user_registration_path }

  context 'when account exists' do
    before do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      fill_in 'Confirm Password', with: user.password
      click_button('Sign up')
    end

    it { expect(page).to have_content('Email has already been taken') }
  end

  context 'when user sign up successfully' do
    before do
      fill_in 'Email', with: 'ruby@gmail.com'
      fill_in 'Password', with: 'Passw0rd'
      fill_in 'Confirm Password', with: 'Passw0rd'
      click_button('Sign up')
    end

    it { expect(page).to have_content(I18n.t('views.devise.registrations.message_with_confirm')) }
  end

  context 'when user sign up not successfully' do
    before do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      fill_in 'Confirm Password', with: 'invalid_password'
      click_button('Sign up')
    end

    it { expect(page).to have_content("Password confirmation doesn't match Password") }
  end
end
