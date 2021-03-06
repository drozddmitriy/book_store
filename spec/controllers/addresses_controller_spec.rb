RSpec.describe AddressesController, type: :controller do
  let!(:user) { create(:user) }

  before { sign_in(user) }

  describe 'GET #index' do
    before { get :index }

    let!(:addresses) { create(:address, addressable: user) }

    it 'return success response' do
      expect(response).to have_http_status(200)
    end

    it 'assigns addresses' do
      expect(addresses).to eq(user.addresses.first)
    end
  end

  describe 'PUT #update' do
    let(:address) { create(:address) }
    let(:address_params) { { address: attributes_for(:address), id: address.id } }

    before { put :update, params: address_params }

    it 'return redirect response' do
      expect(response).to have_http_status(302)
    end
  end

  describe 'POST #create' do
    let(:address_params) { { address: attributes_for(:address) } }

    before { post :create, params: address_params }

    it 'return redirect response' do
      expect(response).to have_http_status(302)
    end

    it 'assigns address' do
      expect(assigns(:address)).to eq(user.addresses.last)
    end
  end
end
