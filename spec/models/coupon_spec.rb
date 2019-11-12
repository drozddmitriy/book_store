require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it { expect(subject).to belong_to(:order).optional }
end
