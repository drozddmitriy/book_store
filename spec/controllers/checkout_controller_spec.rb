RSpec.describe CheckoutController, type: :controller do
  let!(:user) { create(:user) }

  describe 'wicked step' do
    before { sign_in(user) }

    describe 'GET #show' do
      %i[addresses delivery payment confirm complete].each do |step|
        it "redirects from #{step}" do
          get :show, params: { id: step }
          expect(response).to have_http_status(302)
        end
      end
    end

    describe 'PUT #update' do
      let(:addresses_form) do
        { billing: attributes_for(:address, cast: 'billing'),
          shipping: attributes_for(:address, cast: 'shipping') }
      end
      let(:delivery) { create(:delivery) }
      let(:delivery_params) { { delivery_id: delivery.id } }
      let(:credit_card_valid) { attributes_for(:credit_card) }
      let(:credit_card_invalid) { attributes_for(:credit_card, card_number: '') }

      it 'redirect addressess step response' do
        put :update, params: { id: :addresses, addresses_form: addresses_form }
        expect(response).to have_http_status(302)
      end

      it 'redirect delivery step response' do
        put :update, params: { id: :delivery, order: delivery_params }
        expect(response).to have_http_status(302)
      end

      it 'return payment step response' do
        put :update, params: { id: :payment, credit_card: credit_card_valid }
        expect(response).to have_http_status(302)
      end

      it 'redirect confirm step response' do
        put :update, params: { id: :confirm }
        expect(response).to have_http_status(302)
      end
    end
  end
end
