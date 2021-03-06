RSpec.describe Book do
  let(:test_text) { 'test' }
  let(:edit_test_text) { 'edit_test' }

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

    it do
      expect(page).to have_current_path(admin_book_path(described_class.last))
      expect(page).to have_content(described_class.last.title)
    end
  end

  context 'when admin click edit' do
    before { click_link('Edit', match: :first) }

    it { expect(page).to have_current_path(edit_admin_book_path(described_class.last)) }
  end

  context 'when admin edit book' do
    before do
      click_link('Edit', match: :first)
      fill_in 'book[title]', with: edit_test_text
      all('.choices-group').last.set(true)
      all('#book_category_input').first.click
      fill_in 'book[description]', with: edit_test_text
      fill_in 'book[year]', with: 2021
      fill_in 'book[price]', with: 300
      fill_in 'book[material]', with: edit_test_text
      fill_in 'book[dimension_h]', with: 17.5
      fill_in 'book[dimension_w]', with: 17.2
      fill_in 'book[dimension_d]', with: 17.2
      fill_in 'book[quantity]', with: 10
      click_button('Update Book')
    end

    it { expect(page).to have_content(edit_test_text) }
  end
end
