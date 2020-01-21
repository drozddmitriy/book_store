require 'rails_helper'

RSpec.describe ReviewDecorator do
  subject(:decorator) { described_class.new(review) }

  let(:book) { create(:book) }
  let(:user) { create(:user) }
  let(:review) { create(:review, user: user, book: book) }
  let(:logo) { review.user.email.chars.first }

  describe '#logo' do
    it { expect(decorator.logo).to eq(logo) }
  end
end
