RSpec.describe Order, type: :model do
  describe 'validation relations' do
    it { is_expected.to belong_to(:credit_card).optional }
    it { is_expected.to belong_to(:delivery).optional }
    it { is_expected.to have_one(:coupon).dependent(:destroy) }
    it { is_expected.to belong_to(:user).optional }
    it { is_expected.to have_many(:order_items).dependent(:destroy) }
    it { is_expected.to have_many(:addresses).dependent(:destroy) }
  end
end
