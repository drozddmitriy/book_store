require 'rails_helper'

RSpec.describe 'Catalog page', type: :feature do
  let!(:books) { create_list(:book, 3) }

  before { visit books_path }

  context 'when user sort books' do
    before { find_link('Title A-Z', match: :first).click }

    it { expect(page).to have_current_path books_path, ignore_query: true }
    it { expect(all('.title').first.text).to eq books.min_by(&:title).title }
  end

  context 'when user add book to cart' do
    before { find('a.thumb-hover-link.link', match: :first).click }

    it { expect(find('.shop-quantity').text).to eq('1') }
  end
end
