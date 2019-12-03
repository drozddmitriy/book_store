FactoryBot.define do
  factory :address do |address|
    firstname { 'Name' }
    lastname { 'Surname' }
    address { 'Suchkova' }
    city { 'Novomoskovsk' }
    zip { FFaker::AddressDE.zip_code }
    country { FFaker::Address.country_code }
    phone { '+380976245499' }
    cast { 'billing' }
    address.addressable { |a| a.association(:user) }
  end
end
