require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:order_item) { create(:order_item) }

  describe 'GET #index' do
    before { get :index }

    it 'assigns items' do
      expect(assigns(:items)).not_to be_nil
    end

    it 'return success response' do
      expect(response).to have_http_status(200)
    end

    it { is_expected.to render_template(:index) }
  end

  describe 'POST #create' do
    let(:order_item_params) { { order_item: attributes_for(:order_item) } }

    before { post :create, params: order_item_params }

    it 'assigns order_item' do
      expect(assigns(:order_item)).to be_a OrderItem
    end

    it 'return redirect response' do
      expect(response).to have_http_status(302)
    end
  end

  describe 'PUT #update' do
    before do
      put :update, params: { id: order_item.id, order_item: attributes_for(:order_item, quantity: 10) }
    end

    it 'assigns order_item' do
      expect(assigns(:order_item)).to be_a OrderItem
    end

    it 'return redirect response' do
      expect(response).to have_http_status(302)
    end
  end

  describe 'DELETE #destroy' do
    before do
      put :destroy, params: { id: order_item.id, order_item: attributes_for(:order_item, quantity: 1) }
    end

    it 'return redirect response' do
      expect(response).to have_http_status(302)
    end
  end
end
