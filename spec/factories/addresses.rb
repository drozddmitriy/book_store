FactoryBot.define do
  factory :address do |address|
    first_name { FFaker::Lorem.word }
    last_name { FFaker::Lorem.word }
    address { FFaker::Lorem.word }
    city { FFaker::Lorem.word }
    zip { FFaker::AddressDE.zip_code }
    country { FFaker::Address.country_code }
    phone { '+380976245499' }
    cast { 'billing' }
    address.addressable { |a| a.association(:user) }
  end
end
