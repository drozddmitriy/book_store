RSpec.describe OrderFiltersService do
  subject(:order_filters_service) { described_class }

  %w[in_queue in_delivery delivered canceled].each do |type|
    context "when filter #{type}" do
      let(:order) { create(:order, status: type) }
      let(:user) { create(:user, orders: [order]) }
      let(:params) { type }

      it { expect(order_filters_service.new(params, user).filter).to include(order) }
    end
  end
end
