RSpec.describe Book, type: :model do
  it { is_expected.to have_many(:authors).through(:authors_books) }
  it { is_expected.to belong_to(:category) }
  it { is_expected.to have_many(:reviews).dependent(:destroy) }
end
