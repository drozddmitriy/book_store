RSpec.describe ReviewsController, type: :controller do
  let(:book) { create(:book) }
  let(:user) { create(:user) }

  describe 'POST #create' do
    let(:review_params) do
      { book_id: book.id,
        review: attributes_for(:review, user_id: user.id, book_id: book.id) }
    end

    before do
      sign_in(user)
      post :create, xhr: true, params: review_params
    end

    it 'return success response' do
      expect(response).to have_http_status(200)
    end

    it 'assigns review' do
      expect(assigns(:review)).to match(user.reviews.last)
    end
  end
end
