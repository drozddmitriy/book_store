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
      fill_in 'Email', with: 'test@gmail.com'
      fill_in 'Password', with: '123456'
      fill_in 'Confirm Password', with: '123456'
      click_button('Sign up')
    end

    it { expect(page).to have_content('A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.') }
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
