require 'rails_helper'

RSpec.describe Book, type: :model do
  subject { create(:book) }

  it { expect(subject).to have_many(:authors).through(:authors_books) }
  it { expect(subject).to belong_to(:category) }
end
