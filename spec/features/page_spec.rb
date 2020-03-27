RSpec.describe 'Home page', type: :feature do
  before do
    create(:book)
    visit root_path
  end

  context 'when user see latest books' do
    it { expect(find('#slider')).not_to be_nil }
  end

  context 'when user click on buy latest book' do
    before { click_button('Buy Now') }

    it { expect(page).to have_current_path(root_path) }
  end

  context 'when user see get started button' do
    it { expect(page).to have_content('Get Started') }
  end

  context 'when user click on get started button' do
    before { find_link('Get Started').click }

    it { expect(page).to have_current_path(books_path) }
  end
end
