require 'rails_helper'

RSpec.describe CouponsController, type: :controller do
  describe 'PUT #update' do
    context 'when valid coupon' do
      before do
        create(:coupon)
        put :update, params: attributes_for(:coupon)
      end

      it 'redirect to Cart' do
        expect(response).to redirect_to order_items_path
      end

      it 'show success message' do
        expect(flash[:success]).to eq I18n.t('controllers.coupons.coupon_applied')
      end
    end

    context 'when invalid coupon' do
      before do
        create(:coupon)
        put :update, params: { coupon: 'XXXXXX', active: true }
      end

      it { is_expected.to redirect_to order_items_path }

      it 'show error message' do
        expect(flash[:danger]).to eq I18n.t('controllers.coupons.coupon_not_applied')
      end
    end
  end
end
