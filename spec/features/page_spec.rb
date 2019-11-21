require 'rails_helper'

RSpec.describe 'Home page', type: :feature do
  before do
    create(:book)
    visit root_path
  end

  it scenario 'User can see latest books' do
    expect(find('#slider')).not_to be_nil
  end

  it scenario 'User click on buy latest book' do
    click_button('Buy Now')
    expect(page).to have_current_path(root_path)
  end

  it scenario ' User can see get started button' do
    expect(page).to have_content('Get Started')
  end

  it scenario 'User click on get started button' do
    find_link('Get Started').click
    expect(page).to have_current_path(books_path)
  end
end
