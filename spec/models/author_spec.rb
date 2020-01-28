RSpec.describe Author, type: :model do
  describe 'validation relations' do
    it { is_expected.to have_many(:books).through(:authors_books) }
  end

  describe 'validation field first_name' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_length_of(:first_name).is_at_most(50) }
  end

  describe 'validation field last_name' do
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_length_of(:last_name).is_at_most(50) }
  end
end
