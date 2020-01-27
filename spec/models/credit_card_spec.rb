RSpec.describe CreditCard, type: :model do
  it { is_expected.to belong_to(:user).optional }
  it { is_expected.to have_many(:orders).dependent(:destroy) }
end
