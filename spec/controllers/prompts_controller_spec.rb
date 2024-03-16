require 'rails_helper'

RSpec.describe Api::V1::PromptsController, type: :controller do
  shared_examples 'full access to prompts' do
    let(:user) { FactoryBot.create(:user) }
    let(:auth_headers) { user.create_new_auth_token }

    context 'when login' do
      before :each do
        @request.headers.merge! auth_headers
      end

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
          post :set_default_prompt, params: { default_prompt_id: FactoryBot.create(:prompt) }
          expect(response).to have_http_status(:success)
        end
      end
    end

    context 'when not login' do
      it 'redirect to sign in path' do
        get :get_default_prompt
        expect(response).to have_http_status('401')
      end
    end
  end

  shared_examples 'public access to prompts' do
    describe 'GET #default' do

    end
  end

  describe 'user access to prompts' do
    it_behaves_like 'full access to prompts'
    it_behaves_like 'public access to prompts'
  end

  describe 'guess access to prompts' do
    it_behaves_like 'public access to prompts'
  end
end
