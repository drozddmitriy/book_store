require 'rails_helper'

RSpec.describe 'Admin Categories' do
  let(:title) { 'title' }

  before do
    create(:category)

    admin_user = create(:admin_user)
    login_as(admin_user, scope: :admin_user)

    visit admin_categories_path
  end

  it 'Admin can create Category' do
    click_link('New Category')
    fill_in 'category[title]', with: title
    click_button('Create Category')

    expect(page).to have_content(title)
  end

  it 'Admin can edit Category' do
    click_link('Edit', match: :first)

    expect(page).to have_current_path(edit_admin_category_path(Category.last))

    fill_in 'category[title]', with: title
    click_button('Update Category')

    expect(page).to have_content(title)
  end
end
