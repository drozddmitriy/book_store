require 'rails_helper'

RSpec.describe CheckoutUpdateService do
  let(:order) { create(:order, status: 'in_progress') }
  let(:user) { create(:user, orders: [order]) }
  let(:delivery) { create(:delivery) }
  let(:session) { { current_order_complete: true } }
  let(:flash) { ActionDispatch::Flash::FlashHash.new }
  let(:addresses) { create(:address) }
  let(:credit_card) { create(:credit_card) }
  let(:params) { {} }

  context 'when step address' do
    let(:update_service) { described_class.new(:addresses, order, user, params, session, flash) }

    it do
      allow_any_instance_of(described_class).to receive(:addresses) { addresses }
      expect(update_service.call).to eq(addresses)
    end
  end

  context 'when step delivery' do
    let(:update_service) do
      described_class.new(:delivery, order, user, { order: { delivery_id: delivery.id } }, session, flash)
    end

    it do
      allow_any_instance_of(described_class).to receive(:order_params) { { delivery_id: delivery.id } }
      expect(update_service.call.delivery_id).to eq(order.delivery_id)
    end
  end

  context 'when step payment' do
    let(:update_service) { described_class.new(:payment, order, user, params, session, flash) }

    it do
      allow_any_instance_of(described_class).to receive(:payment) { credit_card }
      expect(update_service.call).to eq(credit_card)
    end
  end

  context 'when step confirm' do
    let(:update_service) { described_class.new(:confirm, order, user, params, session, flash) }

    it { expect(update_service.call).to eq(true) }
  end
end
