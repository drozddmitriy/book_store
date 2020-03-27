RSpec.describe OrderItem, type: :model do
  describe 'validation relations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:order).optional }
  end

  describe 'validation field quantity' do
    it { is_expected.to validate_presence_of(:quantity) }
  end
end
