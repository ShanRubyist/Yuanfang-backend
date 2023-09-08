require 'bot'

class Api::V1::CompletionsController < ApplicationController
  include ActionController::Live
  include ModelMap

  before_action :authenticate_user!
  around_action :limit_operations, only: [:achieve]

  attr_reader :sse

  def achieve
    raise 'content can not be empty' unless params['content'].present?
    raise 'site can not be empty' unless params['site'].present?

    response.headers["Content-Type"] = "text/event-stream"
    response.headers["Last-Modified"] = Time.now.httpdate

    client = nil
    MODEL_NAME_2_INSTANCE.each do |item|
      client = item.fetch(:instance) if item.has_value?(params[:site])
    end

    prompt = Api::V1::Prompt.find(params['prompt_id']) rescue nil

    options = {}

    begin
      client.completion(params['content'], prompt&.content, options) do |chunk|
        sse.write chunk
      end
    ensure
      @sse.close rescue nil
    end
  end

  private

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
    "user_hourly_achieve_#{current_user.id}"
  end

  def daily_cache_key
    "user_daily_achieve_#{current_user.id}"
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