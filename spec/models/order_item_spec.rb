RSpec.describe OrderItem, type: :model do
  it { is_expected.to belong_to(:book) }
  it { is_expected.to belong_to(:order).optional }
end
