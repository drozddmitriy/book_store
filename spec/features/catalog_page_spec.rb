RSpec.describe 'Catalog page', type: :feature do
  let!(:books) { create_list(:book, 3) }

  before { visit books_path }

  context 'when user sort books' do
    before do
      within(".dropdowns")do
           find(".pull-right").click
           find_link('Title A-Z', match: :first).click
      end
    end

    it do
      expect(page).to have_current_path books_path, ignore_query: true
      expect(all('.title').first.text).to eq books.min_by(&:title).title
    end
  end

  context 'when user add book to cart' do
    before { find('a.thumb-hover-link.link', visible: false, match: :first).click }

    it { expect(find('.shop-quantity').text).to eq('1') }
    it { expect(page).to have_content('Item add to cart!') }
  end
end
