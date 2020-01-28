RSpec.describe CreditCard, type: :model do
  describe 'validation relations' do
    it { is_expected.to belong_to(:user).optional }
    it { is_expected.to have_many(:orders).dependent(:destroy) }
  end

  describe 'validation field name' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
  end

  describe 'validation field expiration_month_year' do
    it { is_expected.to validate_presence_of(:expiration_month_year) }
    it { is_expected.not_to allow_value('00/20').for(:expiration_month_year) }
    it { is_expected.not_to allow_value('/20').for(:expiration_month_year) }
    it { is_expected.not_to allow_value('00/').for(:expiration_month_year) }
  end

  describe 'validation field card_number' do
    it { is_expected.to validate_presence_of(:card_number) }
    it { is_expected.to validate_numericality_of(:card_number).only_integer }
  end

  describe 'validation field cvv' do
    it { is_expected.to validate_presence_of(:cvv) }
    it { is_expected.to validate_numericality_of(:cvv).only_integer }
    it { is_expected.not_to allow_value(12_345).for(:cvv) }
    it { is_expected.not_to allow_value(0).for(:cvv) }
  end
end
