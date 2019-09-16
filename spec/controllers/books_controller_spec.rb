require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:book) { create(:book) }

  describe 'GET #index' do
    before { get :index }

    it 'return success response' do
      expect(response).to have_http_status(200)
    end

    it 'render :index template' do
      expect(subject).to render_template(:index)
    end

    context 'assigns @filter' do
     it 'equal to DEFAULT_FILTER' do
       expect(assigns(:filter)).to eq(Book::FILTERS.first)
     end

     it 'equal to filter from params' do
       get :index, params: { filter: :popular_first }
       expect(assigns(:filter)).to eq(Book::FILTERS.second)
     end
   end
  end

  describe 'GET #show' do
    before do
      allow(Book).to receive(:find_by) { book }
      get :show, params: { id: book.id }
    end

    it 'assigns @book' do
      expect(assigns(:book)).to match(book)
    end

    it 'return success response' do
      expect(response).to have_http_status(200)
    end

    it 'render :show template' do
      expect(subject).to render_template(:show)
    end
  end
end
