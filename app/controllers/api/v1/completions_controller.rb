require "ruby/openai"

class Api::V1::CompletionsController < ApplicationController
  include ActionController::Live

  before_action :authenticate_user!

  attr_reader :openai_client_for_openai, :openai_client_for_ails, :openai_client_for_api2d, :sse

  def achieve
    raise 'content can not be empty' unless params['content'].present?
    params['model'] ||= "gpt-3.5-turbo"
    params['temperature'] ||= 1

    response.headers["Content-Type"] = "text/event-stream"
    response.headers["Last-Modified"] = Time.now.httpdate
    begin
      case params['site']
      when 'openai'
        client = openai_client_for_openai
      when 'api2d'
        client = openai_client_for_api2d
      when 'ai.ls'
        client = openai_client_for_ails
      else
        client = openai_client_for_api2d
      end

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

  def openai_client(access_token, uri_base = 'https://api.openai.com/', organization_id = '', request_timeout = 240)
    OpenAI.configure do |config|
      config.access_token = access_token
      config.uri_base = uri_base
      config.organization_id = organization_id
      config.request_timeout = request_timeout
    end

    OpenAI::Client.new
  end

  def openai_client_for_openai
    @openai_client_for_openai ||= openai_client(ENV.fetch("OPENAI_API_KEY"), ENV.fetch("OPENAI_API_BASE_URL"), ENV.fetch("OPENAI_ORGANIZATION_ID"))
  end

  def openai_client_for_ails
    @openai_client_for_ails ||= openai_client(ENV.fetch("AILS_API_KEY"), ENV.fetch("AILS_API_BASE_URL"), ENV.fetch("OPENAI_ORGANIZATION_ID"))
  end

  def openai_client_for_api2d
    @openai_client_for_api2d ||= openai_client(ENV.fetch("API2D_API_KEY"), ENV.fetch("API2D_API_BASE_URL"), ENV.fetch("OPENAI_ORGANIZATION_ID"))
  end

  def sse
    # @sse ||= SSE.new(response.stream, event: "openai", retry: 3000)
    @sse ||= SSE.new(response.stream)
  end
end
