RSpec.describe PagesController, type: :controller do
  describe 'GET #home' do
    before { get :home }

    it 'return success response' do
      expect(response).to have_http_status(200)
    end

    it { is_expected.to render_template(:home) }
  end
end
