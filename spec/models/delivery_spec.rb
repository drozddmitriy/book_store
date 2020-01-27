RSpec.describe Delivery, type: :model do
  it { is_expected.to have_many(:orders).dependent(:destroy) }

  %i[name time price].each do |field|
    it { is_expected.to validate_presence_of(field) }
  end
end
