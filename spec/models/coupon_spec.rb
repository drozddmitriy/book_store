require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it { is_expected.to belong_to(:order).optional }
end
