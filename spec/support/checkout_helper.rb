module CheckoutHelper
  def addresses_form
    within('form#address_form') do
      %w[billing shipping].each do |type|
        fill_in "addresses_form[#{type}][first_name]", with: 'test'
        fill_in "addresses_form[#{type}][last_name]", with: 'test'
        fill_in "addresses_form[#{type}][address]", with: 'test'
        fill_in "addresses_form[#{type}][city]", with: 'test'
        fill_in "addresses_form[#{type}][zip]", with: '51200'
        select('Ukraine', from: "addresses_form[#{type}][country]")
        fill_in "addresses_form[#{type}][phone]", with: '+380976245499'
      end
      click_button(I18n.t('views.checkout.save_continue'))
    end
  end

  def credit_card_form
    within('form#new_credit_card') do
      fill_in 'credit_card[card_number]', with: '1234567890123456'
      fill_in 'credit_card[name]', with: 'visa'
      fill_in 'credit_card[expiration_month_year]', with: '12/20'
      fill_in 'credit_card[cvv]', with: '111'
      click_button(I18n.t('views.checkout.save_continue'))
    end
  end

  def credit_card_prepare
    find('a[href="/checkout/login"]').click
    addresses_form
    all('.radio-label').first.click
    click_button(I18n.t('views.checkout.save_continue'))
    credit_card_form
  end
end
