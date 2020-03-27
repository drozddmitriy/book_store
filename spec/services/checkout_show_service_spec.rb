RSpec.describe CheckoutShowService do
  let(:order) { create(:order, status: 'in_progress') }
  let(:user) { create(:user, orders: [order]) }
  let(:deliveries) { create_list(:delivery, 3) }
  let(:session) { { current_order_complete: true } }

  let(:show_service) { described_class.new(:addresses, order, user, session) }

  context 'when step address' do
    it { expect(show_service.call).to be_a AddressesForm }
  end

  context 'when step delivery' do
    let(:step) { :delivery }

    before { show_service.instance_variable_set(:@step, step) }

    it { expect(show_service.call).to match_array(deliveries) }
  end

  context 'when step payment' do
    let(:step) { :payment }

    before { show_service.instance_variable_set(:@step, step) }

    it { expect(show_service.call).to be_a CreditCard }
  end

  context 'when step confirm' do
    let(:step) { :confirm }

    before { show_service.instance_variable_set(:@step, step) }

    it { expect(show_service.call).to eq(order.decorate) }
  end

  context 'when step complete' do
    let(:step) { :complete }

    before { show_service.instance_variable_set(:@step, step) }

    it { expect(show_service.call).to eq(order.decorate) }
  end
end
