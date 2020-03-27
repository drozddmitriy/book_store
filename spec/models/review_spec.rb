RSpec.describe Review, type: :model do
  describe 'validation relations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:book) }
  end

  describe 'validation validation field rating' do
    it { is_expected.to validate_presence_of(:rating) }
    it { is_expected.to validate_numericality_of(:rating).is_less_than_or_equal_to(5) }
  end

  describe 'validation validation field title' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(80) }
  end

  describe 'validation validation field comment' do
    it { is_expected.to validate_presence_of(:comment) }
    it { is_expected.to validate_length_of(:comment).is_at_most(500) }
  end
end
