FactoryBot.define do
  factory :address do |address|
    firstname { FFaker::Name.first_name }
    lastname { FFaker::Name.last_name }
    address { FFaker::Address.street_address }
    city { FFaker::Address.city }
    zip { FFaker::AddressDE.zip_code }
    country { FFaker::Address.country_code }
    phone { FFaker::PhoneNumber.phone_number }
    cast { 'billing' }
    address.addressable { |a| a.association(:user) }
  end
end
