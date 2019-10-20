require 'rails_helper'

RSpec.feature 'Catalog page', type: :feature do
  let!(:books) { create_list(:book, 3) }
  let!(:categories) { Category.all }


  scenario 'User can sort books' do
    visit books_path

    within('div.dropdowns.mb-25.visible-xs') do
      find_link('Title A-Z').click
    end

    expect(page.current_path).to eq books_path
    expect(all('.title').first.text).to eq books.sort_by(&:title).first.title
  end

  scenario 'User can add book to cart' do
    visit books_path

    find('a.thumb-hover-link.link', match: :first).click

    expect(find('.shop-quantity').text).to eq('1')
  end
end
