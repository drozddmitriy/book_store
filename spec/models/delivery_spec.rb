RSpec.describe Delivery, type: :model do
  describe 'validation relations' do
    it { is_expected.to have_many(:orders).dependent(:destroy) }
  end

  describe 'validation field time' do
    it { is_expected.to validate_presence_of(:time) }
  end

  describe 'validation field name' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
  end

  describe 'validation field price' do
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price) }
  end
end
