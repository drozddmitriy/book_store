require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to have_one(:coupon).dependent(:destroy) }
  it { is_expected.to belong_to(:user).optional }
  it { is_expected.to have_many(:order_items).dependent(:destroy) }
  it { is_expected.to have_many(:addresses).dependent(:destroy) }
  it { is_expected.to belong_to(:credit_card).optional }
  it { is_expected.to belong_to(:delivery).optional }
end
