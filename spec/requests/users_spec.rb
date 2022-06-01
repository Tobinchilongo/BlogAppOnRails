require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /index" do
    before(:example) { get '/users' }
    it 'responds with code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders users list view' do
      expect(response).to render_template(:index)
    end

    it 'shows correct content in the view' do
      expect(response.body).to include('List of users')
    end
  end
end
