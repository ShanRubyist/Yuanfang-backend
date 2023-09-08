require 'bot'

module ModelMap
  extend ActiveSupport::Concern

  included do |base|
    base.class_eval do
      MODEL_NAME_2_INSTANCE = [
        { model: 'gpt-3.5-turbo(openai)', instance: openai_35_client, default: false },
        { model: 'gpt-3.5-turbo(api2d.net)', instance: api2d_35_client, default: true },
        { model: 'gpt-3.5-turbo(ai.ls)', instance: ails_35_client, default: true },
        { model: 'gpt-4(api2d.net)', instance: api2d_40_client, default: false },
        { model: 'gpt-4(ai.ls)', instance: ails_40_client, default: false },
        { model: 'llama_7b(baidu)', instance: llama_7b_client, default: true },
        { model: 'llama_13b(baidu)', instance: llama_13b_client, default: true },
        { model: 'llama_70b(baidu)', instance: llama_70b_client, default: true },
        { model: '文心一言(baidu)', instance: llama_ernie_bot_client, default: true },
        { model: '文心一言turbo(baidu)', instance: llama_ernie_bot_turbo_client, default: true },
      ]
    end
  end

  module ClassMethods
    def openai_35_client
      Bot::GptThreePointFive.new(ENV.fetch("OPENAI_API_KEY"), ENV.fetch("OPENAI_API_BASE_URL"), ENV.fetch("OPENAI_ORGANIZATION_ID"))
    end

    def ails_35_client
      Bot::GptThreePointFive.new(ENV.fetch("AILS_API_KEY"), ENV.fetch("AILS_API_BASE_URL"))
    end

    def api2d_35_client
      Bot::GptThreePointFive.new(ENV.fetch("API2D_API_KEY"), ENV.fetch("API2D_API_BASE_URL"))
    end

    def ails_40_client
      Bot::GptFourPointZero.new(ENV.fetch("AILS_API_KEY"), ENV.fetch("AILS_API_BASE_URL"))
    end

    def api2d_40_client
      Bot::GptFourPointZero.new(ENV.fetch("API2D_API_KEY"), ENV.fetch("API2D_API_BASE_URL"))
    end

    def llama_7b_client
      Bot::Llama7b.new(ENV.fetch("BAIDU_API_KEY"), ENV.fetch("BAIDU_SECRET_KEY"), ENV.fetch("BAIDU_API_BASE_URL"))
    end

    def llama_13b_client
      Bot::Llama13b.new(ENV.fetch("BAIDU_API_KEY"), ENV.fetch("BAIDU_SECRET_KEY"), ENV.fetch("BAIDU_API_BASE_URL"))
    end

    def llama_70b_client
      Bot::Llama70b.new(ENV.fetch("BAIDU_API_KEY"), ENV.fetch("BAIDU_SECRET_KEY"), ENV.fetch("BAIDU_API_BASE_URL"))
    end

    def llama_ernie_bot_client
      Bot::ErnieBot.new(ENV.fetch("BAIDU_API_KEY"), ENV.fetch("BAIDU_SECRET_KEY"), ENV.fetch("BAIDU_API_BASE_URL"))
    end

    def llama_ernie_bot_turbo_client
      Bot::ErnieBotTurbo.new(ENV.fetch("BAIDU_API_KEY"), ENV.fetch("BAIDU_SECRET_KEY"), ENV.fetch("BAIDU_API_BASE_URL"))
    end
  end
end