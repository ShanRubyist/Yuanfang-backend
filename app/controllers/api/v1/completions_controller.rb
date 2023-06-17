require "ruby/openai"

class Api::V1::CompletionsController < ApplicationController
  include ActionController::Live

  before_action :authenticate_user!

  attr_reader :client, :sse

  def achieve
    raise 'content can not be empty' unless params['content'].present?
    params['model'] ||= "gpt-3.5-turbo"
    params['temperature'] ||= 1

    response.headers["Content-Type"] = "text/event-stream"
    response.headers["Last-Modified"] = Time.now.httpdate
    begin
      client.chat(
        parameters: {
          model: params['model'],
          messages: [
            { "role": "system", "content": "假设你是个产品设计师，需要根据用户描述给出设计方案、功能提示文案和免责文案" },
            { "role": "system", "content": "以markdown格式返回" },
            { "role": "user", "content": params['content'] }
          ],
          temperature: params['temperature'],
          stream: proc do |chunk, _bytesize|
            sse.write chunk #.dig("choices", 0, "delta", "content")
          end
        })
    rescue => e
      render json: e.to_json, status: 500
    ensure
      @sse.close
    end
  end

  private

  def client
    OpenAI.configure do |config|
      config.access_token = ENV.fetch("OPENAI_API_KEY")
      config.organization_id = ENV.fetch("OPENAI_ORGANIZATION_ID") rescue nil
      config.uri_base = ENV.fetch("OPENAI_API_BASE_URL") { 'https://api.openai.com/' } # 必须http[s] 开头，/ 结尾
      config.request_timeout = 240 # Optional
    end

    @client ||= OpenAI::Client.new
  end

  def sse
    # @sse ||= SSE.new(response.stream, event: "openai", retry: 3000)
    @sse ||= SSE.new(response.stream)
  end
end
