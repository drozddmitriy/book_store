RSpec.describe Address, type: :model do
  it { is_expected.to belong_to(:addressable) }

  %i[first_name last_name address city zip country phone cast].each do |field|
    it { is_expected.to validate_presence_of(field) }
  end
end
