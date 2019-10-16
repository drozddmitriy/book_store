require 'rails_helper'

RSpec.describe CouponsController, type: :controller do
  describe 'PUT #update' do
    let!(:coupon) { create(:coupon) }

    context 'valid coupon' do
      before { put :update, params: { coupon: 'COUPON', active: true } }


      it 'redirect to Cart' do
        expect(response).to redirect_to line_items_path
      end

      it 'show success message' do
        expect(flash[:success]).to eq "Coupon applied!"
      end
    end

    context 'invalid coupon' do
      before { put :update, params: { coupon: 'XXXXXX', active: true } }

      it 'redirect to Cart' do
        expect(subject).to redirect_to line_items_path
      end

      it 'show error message' do
        expect(flash[:danger]).to eq "Coupon not applied"
      end
    end
  end
end
