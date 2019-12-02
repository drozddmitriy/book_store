require 'rails_helper'

RSpec.describe 'Admin Authors' do
  let(:first_name) { 'firstname' }
  let(:last_name) { 'lastname' }

  before do
    create(:author)

    admin_user = create(:admin_user)
    login_as(admin_user, scope: :admin_user)

    visit admin_authors_path
  end

  context 'when admin create Author' do
    before do
      click_link('New Author')
      fill_in 'author[firstname]', with: first_name
      fill_in 'author[lastname]', with: first_name
      click_button('Create Author')
    end

    it { expect(page).to have_content(first_name) }
    it { expect(page).to have_content(first_name) }
  end

  it 'Admin can edit Author' do
    click_link('Edit', match: :first)

    expect(page).to have_current_path(edit_admin_author_path(Author.last))

    fill_in 'author[firstname]', with: first_name
    fill_in 'author[lastname]', with: first_name
    click_button('Update Author')

    expect(page).to have_content(first_name)
    expect(page).to have_content(first_name)
  end
end
