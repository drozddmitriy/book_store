RSpec.describe 'Log in page', type: :feature do
  let!(:user) { create(:user) }

  before { visit new_user_session_path }

  context 'when user log in successfully' do
    before do
      fill_in 'Enter Email', with: user.email
      fill_in 'Password', with: user.password
      click_button('Log in')
    end

    it { expect(page).to have_current_path root_path, ignore_query: true }
    it { expect(page).not_to have_content('Log in') }
    it { expect(page).to have_content('Log out') }
  end

  context 'when user log in not successfully' do
    before do
      fill_in 'Enter Email', with: user.email
      fill_in 'Password', with: 'test'
      click_button('Log in')
    end

    it  { expect(page).to have_current_path new_user_session_path, ignore_query: true }
    it  { expect(page).to have_content('Invalid Email or password.') }
  end
end
