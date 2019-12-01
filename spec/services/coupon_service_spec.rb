require 'rails_helper'

RSpec.describe CouponService do
  subject(:coupon_service) { described_class }

  context 'when generate number' do
    it { expect(coupon_service.generate).to be_a(String) }
    it { expect(coupon_service.generate.size).to eq(10) }
  end
end
