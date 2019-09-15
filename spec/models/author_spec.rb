require 'rails_helper'

RSpec.describe Author, type: :model do
  subject { create(:author) }

  it { expect(subject).to have_many(:books).through(:authors_books) }
end
