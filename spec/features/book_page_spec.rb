require 'rails_helper'

RSpec.feature 'Book page', type: :feature do
  let(:user) { create(:user) }
  let!(:book) { create(:book) }

  it 'User can see detaile information for book' do
     visit book_path(book)

     expect(page).to have_content(book.title)
     expect(page).to have_content(book.decorate.author_full_name)
     expect(page).to have_content(book.price)
     expect(page).to have_content(book.year)
   end

  scenario 'Add to cart' do
    visit book_path(book)

    click_button('Add to Cart')
    expect(find('.shop-quantity').text).to eq('1')
  end

 # scenario 'Write a review', js: true do
 #   login_as(user, scope: :user)
 #   visit book_path(book)
 #   # expect(find('#rating-form')).not_to be_nil
 #
 #   within('#rating-form') do
 #     fill_in 'review[rating]', with: '5'
 #     fill_in 'review[title]', with: 'Title'
 #     fill_in 'review[comment]', with: 'Some test text'
 #   end
 #
 #   click_button('Post')
 #   expect(page).to have_content('Thanks for Review. It will be published as soon as Admin will approve it.')
 # end
end
