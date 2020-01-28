RSpec.describe Coupon, type: :model do
  describe 'validation relations' do
    it { is_expected.to belong_to(:order).optional }
  end

  describe 'validation field sale' do
    it { is_expected.to validate_presence_of(:sale) }
  end

  describe 'validation field coupon' do
    it { is_expected.to validate_length_of(:coupon).is_equal_to(10) }
    it { is_expected.not_to validate_presence_of(:coupon) }
  end

  describe 'validation field active' do
    it { is_expected.not_to validate_presence_of(:active) }
  end
end
