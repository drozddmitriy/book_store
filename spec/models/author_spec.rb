require 'rails_helper'

RSpec.describe Author, type: :model do
  it { expect(subject).to have_many(:books).through(:authors_books) }
end
