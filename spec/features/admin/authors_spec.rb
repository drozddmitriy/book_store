require 'rails_helper'

RSpec.describe Author do
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
      fill_in 'author[lastname]', with: last_name
      click_button('Create Author')
    end

    it { expect(page).to have_content(first_name) }
    it { expect(page).to have_content(last_name) }
  end

  context 'when admin click edit' do
    before { click_link('Edit', match: :first) }

    it { expect(page).to have_current_path(edit_admin_author_path(described_class.last)) }
  end

  context 'when admin edit Author' do
    before do
      click_link('Edit', match: :first)
      fill_in 'author[firstname]', with: first_name
      fill_in 'author[lastname]', with: last_name
      click_button('Update Author')
    end

    it { expect(page).to have_content(first_name) }
    it { expect(page).to have_content(last_name) }
  end
end
