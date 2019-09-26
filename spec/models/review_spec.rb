require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:review) { create(:review, user_id: user.id, book_id: book.id) }

  it { expect(subject).to belong_to(:user) }
  it { expect(subject).to belong_to(:book) }
end
