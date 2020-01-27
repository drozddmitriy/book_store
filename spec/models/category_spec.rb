RSpec.describe Category, type: :model do
  it { is_expected.to have_many(:books).dependent(:destroy) }
end
