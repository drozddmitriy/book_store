require 'rails_helper'

RSpec.describe BookService do
  subject(:book_service) { described_class }

  let(:category) { create(:category) }
  let(:book_1) { create(:book, title: 'Aiybolit', category_id: category.id) }
  let(:book_2) { create(:book, title: 'Noname', category_id: category.id) }
  let!(:books) { [book_1, book_2] }
  let(:filter) { :title_desc }

  context 'with category title' do
    it { expect(book_service.new(category).category_title).to eq(category.title) }
  end

  context 'when select category' do
    it { expect(book_service.new(category.id, filter).call.first.title).to eq(books.second.title) }
  end

  context 'when not select category' do
    it { expect(book_service.new(nil, filter).call.first.title).to eq(books.second.title) }
  end
end
