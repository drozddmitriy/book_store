RSpec.describe Category, type: :model do
  describe 'validation relations' do
    it { is_expected.to have_many(:books).dependent(:destroy) }
  end

  describe 'validation field title' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(50) }
  end
end
