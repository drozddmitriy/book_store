require 'rails_helper'

RSpec.describe BookDecorator do
  subject(:decorator) { described_class.new(book) }

  let(:authors) { [create(:author)] }
  let(:book) { create(:book, authors: authors) }
  let(:book_decorator) { "H: #{book.dimension_h} x W: #{book.dimension_w} x D: #{book.dimension_d}" }
  let(:author_test) { AuthorDecorator.new(authors.first) }

  describe '#book_dimensions' do
    it { expect(decorator.book_dimensions).to eq(book_decorator) }
  end

  describe '#book_reviews' do
    it { expect(decorator.book_reviews).to eq(0) }
  end

  describe '#author_full_name' do
    it { expect(decorator.author_full_name).to eq(author_test.full_name) }
  end
end
