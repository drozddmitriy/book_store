require 'rails_helper'

RSpec.describe LineItem, type: :model do
  it { expect(subject).to belong_to(:book) }
  it { expect(subject).to belong_to(:order).optional }
end
