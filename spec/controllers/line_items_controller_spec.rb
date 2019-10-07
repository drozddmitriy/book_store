require 'rails_helper'

RSpec.describe LineItemsController, type: :controller do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:line_item) { create(:line_item) }

  describe 'GET #index' do
    before { get :index }

    it 'assigns @items' do
      expect(assigns(:items)).not_to be_nil
    end

    it 'return success response' do
      expect(response).to have_http_status(200)
    end

    it 'render :index template' do
      expect(subject).to render_template(:index)
    end
  end

  describe 'POST #create' do
    let(:line_item_params) { { line_item: attributes_for(:line_item) } }
    before { post :create, params: line_item_params }

    it 'assigns @line_item' do
      expect(assigns(:line_item)).to be_a LineItem
    end

    it 'return redirect response' do
      expect(response).to have_http_status(302)
    end
  end

  describe 'PUT #update' do
    before do
      put :update, params: { id: line_item.id, line_item: attributes_for(:line_item, quantity: 10) }
    end

    it 'assigns @line_item' do
      expect(assigns(:line_item)).to be_a LineItem
    end

    it 'return redirect response' do
      expect(response).to have_http_status(302)
    end
  end

  describe 'DELETE #destroy' do
    before do
      put :destroy, params: { id: line_item.id, line_item: attributes_for(:line_item, quantity: 1) }
    end

    it 'return redirect response' do
      expect(response).to have_http_status(302)
    end
  end

end
