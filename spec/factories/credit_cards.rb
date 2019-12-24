FactoryBot.define do
  factory :credit_card do
    name { 'visa' }
    card_number { Array.new(16) { Array(1..9).sample }.join }
    cvv { 123 }
    expiration_month_year { '11/19' }
  end
end
