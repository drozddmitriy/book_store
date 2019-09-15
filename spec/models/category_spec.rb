require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { create(:category) }

  it { expect(subject).to have_many(:books).dependent(:destroy) }
end
