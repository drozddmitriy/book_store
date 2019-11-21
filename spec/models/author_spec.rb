require 'rails_helper'

RSpec.describe Author, type: :model do
  it { is_expected.to have_many(:books).through(:authors_books) }
end
