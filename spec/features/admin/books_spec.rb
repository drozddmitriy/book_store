require 'rails_helper'

RSpec.describe 'Admin Books' do
  let(:test_text) { 'test' }
  before do
    create(:book)

    admin_user = create(:admin_user)
    login_as(admin_user, scope: :admin_user)

    visit admin_books_path
  end

  context 'when admin create book' do
    before do
      click_link('New Book')
      fill_in 'book[title]', with: test_text
      all('.choices-group').first.set(true)
      all('#book_category_input').first.click
      fill_in 'book[description]', with: test_text
      fill_in 'book[year]', with: 2020
      fill_in 'book[price]', with: 100
      fill_in 'book[material]', with: test_text
      fill_in 'book[dimension_h]', with: 12.5
      fill_in 'book[dimension_w]', with: 12.2
      fill_in 'book[dimension_d]', with: 12.2
      fill_in 'book[quantity]', with: 1
      click_button('Create Book')
    end

    it { expect(page).to have_content(test_text) }
  end

  context 'when admin view book' do
    before { click_link('View', match: :first) }

    it { expect(page).to have_current_path(admin_book_path(Book.last)) }
    it { expect(page).to have_content(Book.last.title) }
  end

  it 'Admin can edit book' do
    click_link('Edit', match: :first)

    expect(page).to have_current_path(edit_admin_book_path(Book.last))

    fill_in 'book[title]', with: test_text
    all('.choices-group').first.set(true)
    all('#book_category_input').first.click
    fill_in 'book[description]', with: test_text
    fill_in 'book[year]', with: 2020
    fill_in 'book[price]', with: 100
    fill_in 'book[material]', with: test_text
    fill_in 'book[dimension_h]', with: 12.5
    fill_in 'book[dimension_w]', with: 12.2
    fill_in 'book[dimension_d]', with: 12.2
    fill_in 'book[quantity]', with: 1
    click_button('Update Book')

    expect(page).to have_content(test_text)
  end
end
