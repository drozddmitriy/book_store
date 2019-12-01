require 'rails_helper'

RSpec.describe CheckoutStepService do
  let(:session) { { current_order_complete: 'complete' } }
  let(:delivery) { create(:delivery) }
  let(:credit_card) { create(:credit_card) }
  let(:order) { create(:order, delivery: delivery, credit_card: credit_card) }

  let(:checkout_step_service) { described_class.new(order, :addresses, session) }

  context 'when step address' do
    it { expect(checkout_step_service.call).to eq(true) }
  end

  context 'when step delivery' do
    let(:step) { :delivery }

    before { checkout_step_service.instance_variable_set(:@step, step) }

    it { expect(checkout_step_service.call).to be_nil }
  end

  context 'when step payment' do
    let(:step) { :payment }

    before { checkout_step_service.instance_variable_set(:@step, step) }

    it { expect(checkout_step_service.call).to eq(order.delivery) }
  end

  context 'when step confirm' do
    let(:step) { :confirm }

    before { checkout_step_service.instance_variable_set(:@step, step) }

    it { expect(checkout_step_service.call).to eq(order.credit_card) }
  end

  context 'when step complete' do
    let(:step) { :complete }

    before { checkout_step_service.instance_variable_set(:@step, step) }

    it { expect(checkout_step_service.call).to eq(session[:current_order_complete]) }
  end
end
