require 'rails_helper'

RSpec.describe Order, type: :model do
  it { expect(subject).to have_one(:coupon).dependent(:destroy) }
  it { expect(subject).to belong_to(:user).optional }
  it { expect(subject).to have_many(:line_items).dependent(:destroy) }
  it { expect(subject).to have_many(:addresses).dependent(:destroy) }
  it { expect(subject).to belong_to(:credit_card).optional }
  it { expect(subject).to belong_to(:delivery).optional }
end
