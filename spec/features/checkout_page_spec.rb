require 'rails_helper'

RSpec.describe 'Checkout page', type: :feature do
  let(:user) { create(:user) }
  let(:order) { create(:order) }

  before do
    create(:book)
    create_list(:delivery, 3)
  end

  it 'user checkout order' do
    login_as(user, scope: :user)
    visit root_path

    find('input[value="Buy Now"]').click
    find('a.shop-link.hidden-xs').click
    expect(page).to have_current_path line_items_path, ignore_query: true

    find('a[href="/checkout/login"]').click
    expect(page).to have_current_path checkout_path(:addresses), ignore_query: true

    within('form#address_form') do
      %w[billing shipping].each do |type|
        fill_in "addresses_form[#{type}][firstname]", with: 'test'
        fill_in "addresses_form[#{type}][lastname]", with: 'test'
        fill_in "addresses_form[#{type}][address]", with: 'test'
        fill_in "addresses_form[#{type}][city]", with: 'test'
        fill_in "addresses_form[#{type}][zip]", with: 'test'
        select('Ukraine', from: "addresses_form[#{type}][country]")
        fill_in "addresses_form[#{type}][phone]", with: '+380976245499'
      end

      click_button('Save and Continue')
    end
    expect(page).to have_current_path checkout_path(:delivery), ignore_query: true

    all('.radio-label').first.click
    click_button('Save and Continue')
    expect(page).to have_current_path checkout_path(:payment), ignore_query: true

    within('form#new_credit_card') do
      fill_in 'credit_card[card_number]', with: '1234567890123456'
      fill_in 'credit_card[name]', with: 'visa'
      fill_in 'credit_card[expiration_month_year]', with: '12/20'
      fill_in 'credit_card[cvv]', with: '111'

      click_button('Save and Continue')
    end
    expect(page).to have_current_path checkout_path(:confirm), ignore_query: true

    click_button('Place Order')
    expect(page).to have_current_path checkout_path(:complete), ignore_query: true
    expect(page).to have_content I18n.t('views.checkout.email', email: user.email)
  end
end
