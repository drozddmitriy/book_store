RSpec.describe Author do
  let(:first_name) { 'first_name' }
  let(:last_name) { 'last_name' }

  before do
    create(:author)

    admin_user = create(:admin_user)
    login_as(admin_user, scope: :admin_user)

    visit admin_authors_path
  end

  context 'when admin create Author' do
    before do
      click_link('New Author')
      fill_in 'author[first_name]', with: first_name
      fill_in 'author[last_name]', with: last_name
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
      fill_in 'author[first_name]', with: first_name
      fill_in 'author[last_name]', with: last_name
      click_button('Update Author')
    end

    it { expect(page).to have_content(first_name) }
    it { expect(page).to have_content(last_name) }
  end
end
