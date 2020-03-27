RSpec.describe Category do
  let(:title) { 'title' }

  before do
    create(:category)

    admin_user = create(:admin_user)
    login_as(admin_user, scope: :admin_user)

    visit admin_categories_path
  end

  context 'when admin create Category' do
    before do
      click_link('New Category')
      fill_in 'category[title]', with: title
      click_button('Create Category')
    end

    it { expect(page).to have_content(title) }
  end

  context 'when admin click edit' do
    before { click_link('Edit', match: :first) }

    it { expect(page).to have_current_path(edit_admin_category_path(described_class.last)) }
  end

  context 'when admin edit Category' do
    before do
      click_link('Edit', match: :first)
      fill_in 'category[title]', with: title
      click_button('Update Category')
    end

    it { expect(page).to have_content(title) }
  end
end
