RSpec.describe User, type: :model do
  describe 'validation relations' do
    it { is_expected.to have_many(:addresses).dependent(:destroy) }
    it { is_expected.to have_many(:reviews).dependent(:destroy) }
    it { is_expected.to have_many(:orders).dependent(:destroy) }
    it { is_expected.to have_many(:order_items).through(:orders).dependent(:destroy) }
    it { is_expected.to have_one(:credit_card).dependent(:destroy) }
  end

  describe 'password complexity' do
    let(:user) { build(:user, password: password) }

    before { user.save }

    context 'when success' do
      let(:password) { 'Passw0rd' }

      it { expect(user).to be_valid }
    end

    context 'when failure' do
      let(:password) { 'adasdsadsad' }

      it { expect(user).to be_invalid }
      it { expect(user.errors[:password]).to include(I18n.t('models.user.password')) }
    end
  end

  describe '#from_omniauth' do
    let(:auth_hash) do
      OmniAuth::AuthHash.new(
        provider: 'facebook',
        uid: '12345',
        info: { email: 'user@example.com' }
      )
    end

    let(:user) do
      described_class.new(
        provider: 'facebook',
        uid: 12_345,
        email: 'user@example.com',
        password: 'Passw0rd',
        password_confirmation: 'Passw0rd'
      )
    end

    context 'when retrieves an existing user' do
      it do
        user.save
        omniauth_user = described_class.from_omniauth(auth_hash)
        expect(user).to eq(omniauth_user)
      end
    end

    context "when creates a new user if one doesn't already exist" do
      it { expect(described_class.count).to eq(0) }

      it do
        described_class.from_omniauth(auth_hash)
        expect(described_class.count).to eq(1)
      end
    end
  end
end
