require 'bot'

class Api::V1::CompletionsController < ApplicationController
  include ActionController::Live
  include ModelMap

  rescue_from RuntimeError do |e|
    render json: { error: e }.to_json, status: 500
  end

  before_action :authenticate_user!
  around_action :limit_operations, only: [:achieve]

  attr_reader :sse

  def achieve
    question = params['content']
    site = params['site']
    achieve_id = params['achieve_id'] || SecureRandom.uuid

    raise 'content can not be empty' unless question.present?
    raise 'site can not be empty' unless site.present?

    response.headers["Content-Type"] = "text/event-stream"
    response.headers["Last-Modified"] = Time.now.httpdate

    client = nil
    MODEL_NAME_2_INSTANCE.each do |item|
      client = item.fetch(:instance) if item.has_value?(params[:site])
    end

    prompt = Api::V1::Prompt.find(params['prompt_id']) rescue nil

    options = {}
    total_answer = []
    total_original_answer = []

    begin
      client.completion(question, prompt&.content, options) do |chunk, original_chunk|
        sse.write chunk

        total_answer << chunk.transform_keys(&:to_sym)[:choices]
                          .first
                          .transform_keys(&:to_sym)[:delta]
                          .transform_keys(&:to_sym)[:content] rescue nil

        total_original_answer << original_chunk
      end
    ensure
      save_achieve_to_db({ achieve_id: achieve_id,
                           question: question,
                           prompt: prompt&.content,
                           params: params,
                           site: site,
                           total_answer: total_answer.join,
                           total_original_answer: total_original_answer.to_s
                         })

      @sse.close rescue nil
    end
  end

  private

  def save_achieve_to_db(h)
    achieve_id = h.fetch(:achieve_id)
    question = h.fetch(:question)
    prompt = h.fetch(:prompt)
    params = h.fetch(:params)
    site = h.fetch(:site)
    total_answer = h.fetch(:total_answer)
    total_original_answer = h.fetch(:total_original_answer)

    achieve_question = current_user
                         .achieve_questions
                         .create_with(question: question, prompt: prompt, origin_params: params)
                         .find_or_create_by(achieve_id: achieve_id)

    achieve_question.achieve_answers
                    .create({ site: site, respond: total_answer, original_respond: total_original_answer })
  end

  def sse
    # @sse ||= SSE.new(response.stream, event: "openai", retry: 3000)
    @sse ||= SSE.new(response.stream)
  end

  def limit_operations
    if !exceedsHourlyLimit? && !exceedsDailyLimit?
      yield

      self.hourly_usage_count = self.hourly_usage_count + 1
      self.daily_usage_count = self.daily_usage_count + 1
    end
  end

  def hourly_cache_key
    "user_hourly_achieve_#{current_user.id}" if current_user
  end

  def daily_cache_key
    "user_daily_achieve_#{current_user.id}" if current_user
  end

  def hourly_usage_count
    Rails.cache.fetch(hourly_cache_key) { 0 }
  end

  def daily_usage_count
    Rails.cache.fetch(daily_cache_key) { 0 }
  end

  def hourly_usage_count=(n)
    Rails.cache.write(hourly_cache_key, n, expires_in: 1.hour)
  end

  def daily_usage_count=(n)
    Rails.cache.write(daily_cache_key, n, expires_in: 1.day)
  end

  def max_operations_per_day
    50
  end

  def max_operations_per_hour
    30
  end

  def exceedsHourlyLimit?
    fail "一小时最多请求#{max_operations_per_hour}次" unless hourly_usage_count < max_operations_per_hour
    false
  end

  def exceedsDailyLimit?
    fail "一天最多请求#{max_operations_per_day}次" unless daily_usage_count < max_operations_per_day
    false
  end
end