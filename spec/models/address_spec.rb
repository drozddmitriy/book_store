require 'rails_helper'

RSpec.describe Address, type: :model do
  it { is_expected.to belong_to(:addressable) }

  %i[firstname lastname address city zip country phone cast].each do |field|
    it { is_expected.to validate_presence_of(field) }
  end
end
