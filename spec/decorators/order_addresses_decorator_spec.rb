RSpec.describe OrderAddressesDecorator do
  subject(:decorator) { described_class.new(address) }

  let(:address) { create(:address) }

  describe '#capitalize_address' do
    let(:capitalize_address) { "#{address.cast.capitalize} Address" }

    it { expect(decorator.capitalize_address).to eq(capitalize_address) }
  end

  describe '#full_name' do
    let(:full_name) { "#{address.first_name} #{address.last_name}" }

    it { expect(decorator.full_name).to eq(full_name) }
  end

  describe '#city_zip' do
    let(:city_zip) { "#{address.city} #{address.zip}" }

    it { expect(decorator.city_zip).to eq(city_zip) }
  end

  describe '#phone_address' do
    let(:phone_address) { "Phone #{address.phone}" }

    it { expect(decorator.phone_address).to eq(phone_address) }
  end
end
