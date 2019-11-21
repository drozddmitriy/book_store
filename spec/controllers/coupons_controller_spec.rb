require 'rails_helper'

RSpec.describe CouponsController, type: :controller do
  describe 'PUT #update' do
    context 'when valid coupon' do
      before do
        create(:coupon)
        put :update, params: { coupon: 'COUPONNNNN', active: true }
      end

      it 'redirect to Cart' do
        expect(response).to redirect_to line_items_path
      end

      it 'show success message' do
        expect(flash[:success]).to eq 'Coupon applied!'
      end
    end

    context 'when invalid coupon' do
      before do
        create(:coupon)
        put :update, params: { coupon: 'XXXXXX', active: true }
      end

      it { is_expected.to redirect_to line_items_path }

      it 'show error message' do
        expect(flash[:danger]).to eq 'Coupon not applied!'
      end
    end
  end
end
