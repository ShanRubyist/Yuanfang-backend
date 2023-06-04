require "ruby/openai"

class Api::V1::CompletionsController < ApplicationController
  before_action :authenticate_user!

  attr_reader :client

  def achieve
    raise 'prompt can not be empty' unless params['prompt'].present?

    model = "text-davinci-003"
    prompt = params['prompt']
    max_tokens = 4096
    response = client.completions(
      parameters: {
        model: model,
        prompt: prompt,
        max_tokens: max_tokens
      })

    render json: {
      answer: (response["choices"].map { |c| c["text"] }).to_json
    }
  end

  private

  def client
    OpenAI.configure do |config|
      config.access_token = ENV.fetch("OPENAI_API_KEY")
      config.organization_id = ENV.fetch("OPENAI_ORGANIZATION_ID") rescue nil
      config.uri_base = ENV.fetch("OPENAI_API_BASE_URL") { 'https://api.openai.com/'}   # 必须http[s] 开头，/ 结尾
      config.request_timeout = 240 # Optional
    end

    @client = OpenAI::Client.new
  end
end
