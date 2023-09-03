require 'bot'

class Api::V1::CompletionsController < ApplicationController
  include ActionController::Live

  before_action :authenticate_user!

  attr_reader :openai_client_for_openai, :openai_client_for_ails, :openai_client_for_api2d, :sse

  def achieve
    raise 'content can not be empty' unless params['content'].present?

    response.headers["Content-Type"] = "text/event-stream"
    response.headers["Last-Modified"] = Time.now.httpdate

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

    prompt = Api::V1::Prompt.find(params['prompt_id']) rescue nil

    begin
      client.completion(params['content'], prompt&.content) do |chunk|
        sse.write chunk
      end
    rescue => e
      render json: e.to_json, status: 500
    ensure
      @sse.close
    end
  end

  private

  def sse
    # @sse ||= SSE.new(response.stream, event: "openai", retry: 3000)
    @sse ||= SSE.new(response.stream)
  end

  def openai_client_for_openai
    @openai_client_for_openai ||=
      Bot::OpenAI.new(ENV.fetch("OPENAI_API_KEY"), ENV.fetch("OPENAI_API_BASE_URL"), ENV.fetch("OPENAI_ORGANIZATION_ID"))
  end

  def openai_client_for_ails
    @openai_client_for_ails ||= Bot::OpenAI.new(ENV.fetch("AILS_API_KEY"), ENV.fetch("AILS_API_BASE_URL"))
  end

  def openai_client_for_api2d
    @openai_client_for_api2d ||= Bot::OpenAI.new(ENV.fetch("API2D_API_KEY"), ENV.fetch("API2D_API_BASE_URL"))
  end
end
