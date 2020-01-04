require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  let!(:user) { create(:user) }

  before do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #quik_register' do
    context 'when user exist' do
      let(:user_params) { { user: { email: user.email.to_s } } }
      let(:danger) { 'Email invalid' }

      before { post :quik_register, params: user_params }

      it 'return redirect response' do
        expect(response).to redirect_to(checkout_path(:login))
      end

      it 'assigns user' do
        expect(flash[:danger]).to eq(danger)
      end
    end

    context 'when new user' do
      let(:user_params) { { user: { email: 'larisa.carroll@heller.biz' } } }

      before { post :quik_register, params: user_params }

      it 'return redirect response' do
        expect(response).to redirect_to(checkout_path(:addresses))
      end

      it 'assigns user' do
        expect(user).not_to be_nil
      end
    end
  end
end
