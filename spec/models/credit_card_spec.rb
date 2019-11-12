require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  it { expect(subject).to belong_to(:user).optional }
  it { expect(subject).to have_many(:orders).dependent(:destroy) }

end
