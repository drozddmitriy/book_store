require 'rails_helper'

RSpec.describe Coupon, type: :model do
  let(:order) { create(:order) }
  
  it { expect(subject).to belong_to(:order).optional }
end
