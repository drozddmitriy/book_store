require 'rails_helper'

RSpec.describe AddressService do
  subject(:address_service) { described_class }

  let(:user) { create(:user) }
  let(:address) { create(:address) }

  context 'when address presence' do
    it { expect(address_service.new(user, address).billing.id).to eq(address.id) }
  end

  context 'when address not presence' do
    it { expect(address_service.new(user, nil).billing.id).to be_nil }
  end
end
