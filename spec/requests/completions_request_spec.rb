require 'rails_helper'

RSpec.describe "completions", type: :request do

  context 'as login user' do
    login_user

    it 'redirect to root_path' do
      post '/api/v1/achieve', params: {content: 'say a joke', site: '文心一言(baidu)', format: 'application/json'}
      expect(response).to have_http_status('200')
    end
  end

  context 'as guest' do
    it 'show unauthorized' do
      post '/api/v1/achieve', params: {content: 'say a joke', site: '文心一言(baidu)', format: 'application/json'}
      expect(response).to have_http_status('401')
    end
  end
end