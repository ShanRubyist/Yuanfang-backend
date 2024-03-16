require 'rails_helper'

RSpec.describe Api::V1::CompletionsController, type: :controller do
  shared_examples 'full access to completions' do
    let(:user) { FactoryBot.create(:user) }
    let(:auth_headers) { user.create_new_auth_token }

    describe 'POST #achieve' do
      context 'when login' do
        before :each do
          @request.headers.merge! auth_headers
        end

        it 'return a 200' do
          post :achieve, params: { content: 'say a joke', site: '文心一言(baidu)', format: 'application/json' }
          expect(response).to have_http_status(:success)
          expect(response.body).to match /data:/
        end

        it 'has correct response headers' do
          post :achieve, params: { content: 'say a joke', site: '文心一言(baidu)', format: 'application/json' }
          expect(response.headers['Content-Type']).to match(/text\/event-stream/)
        end

        it 'has correct ENV' do
          stub_const("ENV", "RACK_ENV" => "test")
          expect(ENV['RACK_ENV']).to eq 'test'
        end

        # it 'assigns the requested sse to @sse' do
        #   expect(assigns(:sse)).to not_eq nil
        # end
      end

      context 'when not login' do
        it 'redirect to sign in path' do
          post :achieve, params: { content: 'say a joke', site: '文心一言(baidu)', format: 'application/json' }
          expect(response).to have_http_status('401')
          expect(response.headers['Content-Type']).to match(/application\/json; charset=utf-8/)
        end
      end
    end
  end

  shared_examples 'public access to completions' do
    describe 'POST #achieve' do

    end
  end

  describe 'user access to completions' do
    it_behaves_like 'full access to completions'
    it_behaves_like 'public access to completions'
  end

  describe 'guess access to completions' do
    it_behaves_like 'public access to completions'
  end
end
