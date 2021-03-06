RSpec.describe BooksController, type: :controller do
  let(:book) { create(:book) }

  describe 'GET #index' do
    before { get :index }

    it 'return success response' do
      expect(response).to have_http_status(200)
    end

    it { is_expected.to render_template(:index) }

    context 'when assigns filter' do
      it 'equal to default filter' do
        expect(assigns(:sorts)).to eq(BookSortService::SORTS.keys.first)
      end

      it 'equal to filter from params' do
        get :index, params: { sort: :pop_first }
        expect(assigns(:sorts)).to eq(BookSortService::SORTS.keys.second)
      end
    end
  end

  describe 'GET #show' do
    before do
      allow(Book).to receive(:find_by) { book }
      get :show, params: { id: book.id }
    end

    it 'assigns book' do
      expect(assigns(:book)).to match(book)
    end

    it 'return success response' do
      expect(response).to have_http_status(200)
    end

    it { is_expected.to render_template(:show) }
  end
end
