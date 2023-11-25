require 'rails_helper'

RSpec.describe Api::V1::CompletionsController, type: :controller do
  shared_examples 'user access to completions' do
    login_user

    describe 'POST #achieve' do
      it 'return a 200' do
        post :achieve
        expect(response).to have_http_status(:success)
      end

      it 'has correct response headers' do
        post :achieve
        expect(response.headers['Content-Type']).to match(/application\/json; charset=utf-8/)
      end

      it 'has correct ENV' do
        stub_const("ENV", "RACK_ENV" => "test")
        expect(ENV['RACK_ENV']).to eq 'test'
      end

      # it 'assigns the requested sse to @sse' do
      #   expect(assigns(:sse)).to not_eq nil
      # end
    end
  end

  shared_examples 'guess access to completions' do
    describe 'POST #achieve' do
      it 'redirect to sign in path' do
        post :achieve
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'user access to completions' do
    it_behaves_like 'user access to completions'
  end

  describe 'guess access to completions' do
    it_behaves_like 'guess access to completions'
  end
end
