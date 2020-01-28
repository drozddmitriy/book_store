RSpec.describe Book, type: :model do
  describe 'validation relations' do
    it { is_expected.to have_many(:authors).through(:authors_books) }
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:reviews).dependent(:destroy) }
    it { is_expected.to have_many(:authors_books).dependent(:destroy) }
    it { is_expected.to have_many(:order_items).dependent(:destroy) }
  end

  describe 'validation field title' do
    it { is_expected.to validate_presence_of(:title) }
  end

  describe 'validation field quantity' do
    it { is_expected.to validate_presence_of(:quantity) }
  end

  describe 'validation field dimension_h' do
    it { is_expected.to validate_presence_of(:dimension_h) }
  end

  describe 'validation field dimension_w' do
    it { is_expected.to validate_presence_of(:dimension_w) }
  end

  describe 'validation field dimension_d' do
    it { is_expected.to validate_presence_of(:dimension_d) }
  end

  describe 'validation field year' do
    it { is_expected.to validate_numericality_of(:year).is_less_than_or_equal_to(Time.current.year) }
  end

  describe 'validation field description' do
    it { is_expected.to validate_length_of(:description).is_at_most(2000) }
  end

  describe 'validation field price' do
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  end
end
