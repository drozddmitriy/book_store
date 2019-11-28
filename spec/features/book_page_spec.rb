require 'rails_helper'

RSpec.describe 'Book page', type: :feature do
  let(:user) { create(:user) }
  let!(:book) { create(:book) }

  context 'when user see detaile information for book' do
    before { visit book_path(book) }

    it { expect(page).to have_content(book.title) }
    it { expect(page).to have_content(book.decorate.author_full_name) }
    it { expect(page).to have_content(book.price) }
    it { expect(page).to have_content(book.year) }
  end

  context 'when user add to cart' do
    before do
      visit book_path(book)
      click_button('Add to Cart')
    end

    it { expect(find('.shop-quantity').text).to eq('1') }
  end

  context 'Write a review' do
    before do
      login_as(user, scope: :user)
      visit book_path(book)
      find("#rating-form").set("5")
      fill_in 'review[title]', with: 'Title'
      fill_in 'review[comment]', with: 'Some test text'
      click_button('Post')
    end
    
    it { expect(page).to have_content('Thanks for Review. It will be published as soon as Admin will approve it.') }
  end
end
