require 'rails_helper'

RSpec.describe Api::V1::InfoController, type: :controller do
    describe 'GET #models' do
      it 'return a 200' do
        get :models
        expect(response).to have_http_status(:success)
      end

      it 'has correct response headers' do
        get :models
        expect(response.headers['Content-Type']).to match(/application\/json; charset=utf-8/)
      end
  end
end
