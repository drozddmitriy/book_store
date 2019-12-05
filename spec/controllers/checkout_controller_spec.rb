require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  let!(:user) { create(:user) }

  describe 'step login' do
    context '#show'
    let(:step) { :login }

    before do
      get :show, params: { id: 'login' }
    end

    it 'return success response' do
      expect(response).to have_http_status(200)
    end

    it { is_expected.to render_template(:login) }
  end

  describe 'wicked step' do
    before { sign_in(user) }

    describe '#show' do
      %i[addresses delivery payment confirm complete].each do |step|
        it "redirects from #{step}" do
          get :show, params: { id: step }
          expect(response).to have_http_status(302)
        end
      end
    end

    describe '#update' do
      context 'when addressess step' do
        let(:addresses_form) do
          { billing: attributes_for(:address, cast: 'billing'),
            shipping: attributes_for(:address, cast: 'shipping') }
        end

        it 'return a redirect response' do
          put :update, params: { id: :addresses, addresses_form: addresses_form }
          expect(response).to have_http_status(302)
        end
      end

      context 'when delivery step' do
        let(:delivery) { create(:delivery) }
        let(:delivery_params) { { delivery_id: delivery.id } }

        it 'return a redirect response' do
          put :update, params: { id: :delivery, order: delivery_params }
          expect(response).to have_http_status(302)
        end
      end

      context 'when payment step' do
        let(:credit_card_valid) { attributes_for(:credit_card) }
        let(:credit_card_invalid) { attributes_for(:credit_card, card_number: '') }

        it 'return redirect response' do
          put :update, params: { id: :payment, credit_card: credit_card_valid }
          expect(response).to have_http_status(302)
        end
      end

      context 'when confirm step' do
        it 'return a redirect response' do
          put :update, params: { id: :confirm }
          expect(response).to have_http_status(302)
        end
      end
    end
  end
end
