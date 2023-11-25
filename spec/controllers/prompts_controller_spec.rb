require 'rails_helper'

RSpec.describe Api::V1::PromptsController, type: :controller do
  shared_examples 'user access to prompts' do
    login_user

    describe 'GET #default' do
      it 'return a 200' do
        get :get_default_prompt
        expect(response).to have_http_status(:success)
      end

      it 'has correct response headers' do
        get :get_default_prompt
        expect(response.headers['Content-Type']).to match(/application\/json; charset=utf-8/)
      end
    end

    describe 'POST #default' do
      it 'return a 200' do
        post :set_default_prompt, params: {default_prompt_id: FactoryBot.create(:prompt)}
        expect(response).to have_http_status(:success)
      end
    end
  end

  shared_examples 'guess access to prompts' do
    describe 'GET #default' do
      it 'redirect to sign in path' do
        get :get_default_prompt
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'user access to prompts' do
    it_behaves_like 'user access to prompts'
  end

  describe 'guess access to prompts' do
    it_behaves_like 'guess access to prompts'
  end
end
