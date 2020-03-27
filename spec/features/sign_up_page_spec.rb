RSpec.describe 'Registration', type: :feature do
  let(:user) { create(:user) }

  before { visit new_user_registration_path }

  context 'when account exists' do
    before do
      fill_in I18n.t('views.devise.registrations.email'), with: user.email
      fill_in I18n.t('views.devise.registrations.password'), with: user.password
      fill_in I18n.t('views.devise.registrations.confirm_password'), with: user.password
      click_button(I18n.t('views.devise.registrations.sign_up'))
    end

    it { expect(page).to have_content('Email has already been taken') }
  end

  context 'when user sign up successfully' do
    before do
      fill_in I18n.t('views.devise.registrations.email'), with: 'ruby@gmail.com'
      fill_in I18n.t('views.devise.registrations.password'), with: 'Passw0rd'
      fill_in I18n.t('views.devise.registrations.confirm_password'), with: 'Passw0rd'
      click_button(I18n.t('views.devise.registrations.sign_up'))
    end

    it { expect(page).to have_content(I18n.t('views.devise.registrations.message_with_confirm')) }
  end

  context 'when user sign up not successfully' do
    before do
      fill_in I18n.t('views.devise.registrations.email'), with: user.email
      fill_in I18n.t('views.devise.registrations.password'), with: user.password
      fill_in I18n.t('views.devise.registrations.confirm_password'), with: 'invalid_password'
      click_button(I18n.t('views.devise.registrations.sign_up'))
    end

    it { expect(page).to have_content("Password confirmation doesn't match Password") }
  end
end
