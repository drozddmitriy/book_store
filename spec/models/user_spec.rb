require 'rails_helper'

RSpec.describe User, type: :model do
  it { expect(subject).to have_many(:addresses).dependent(:destroy) }
  it { expect(subject).to have_many(:reviews).dependent(:destroy) }
end
