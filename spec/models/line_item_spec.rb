require 'rails_helper'

RSpec.describe LineItem, type: :model do
  let(:book) { create(:book) }
  let(:order) { create(:order) }

  it { expect(subject).to belong_to(:book) }
  it { expect(subject).to belong_to(:order).optional }
end
