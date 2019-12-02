require 'rails_helper'

RSpec.describe 'Admin Reviews' do
  let!(:review) { create(:review) }

  before do
    admin_user = create(:admin_user)
    login_as(admin_user, scope: :admin_user)

    visit admin_reviews_path
  end

  context 'when admin show' do
    before { click_link('Show', match: :first) }

    it { expect(page).to have_content(review.title) }
  end

  context 'when admin publish' do
    before do
      click_link('Show', match: :first)
      click_link('Publish')
    end

    it { expect(page).to have_content('Yes') }
  end

  context 'when admin unpublish' do
    let(:review) { create(:review, publish: true) }

    before do
      click_link('Show', match: :first)
      click_link('Unpublish')
    end

    it { expect(page).to have_content('No') }
  end
end
