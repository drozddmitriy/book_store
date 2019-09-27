require 'rails_helper'

RSpec.describe Address, type: :model do
  it { expect(subject).to belong_to(:addressable) }
end
