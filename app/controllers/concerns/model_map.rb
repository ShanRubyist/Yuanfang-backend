require 'bot'

module ModelMap
  extend ActiveSupport::Concern

  included do |base|
    base.class_eval do
      MODEL_NAME_2_INSTANCE = [
      { model: 'gpt-3.5-turbo(openai)', instance: openai_35_client, default: false },
        { model: 'gpt-3.5-turbo(api2d.net)', instance: api2d_35_client, default: true },
        { model: 'gpt-3.5-turbo(ai.ls)', instance: ails_35_client, default: false },
        { model: 'gpt-3.5-turbo(智增增)', instance: smarttrot_gpt_3_5_client, default: false },
        { model: 'gpt-4(api2d.net)', instance: api2d_40_client, default: false },
        { model: 'gpt-4(ai.ls)', instance: ails_40_client, default: false },
        { model: 'gpt-4(智增增)', instance: smarttrot_gpt_4_0_client, default: false },
        { model: 'claude 2(theb.ai)', instance: thebai_claude_2_client, default: false },
        { model: 'claude 2(智增增)', instance: smarttrot_claude_2_client, default: false },
        { model: 'claude 1 100k(theb.ai)', instance: thebai_claude_1_100k_client, default: false },
        { model: 'claude 1 100k(智增增)', instance: smarttrot_claude_1_client, default: false },
        { model: 'search(theb.ai)', instance: thebai_search_client, default: false },
        { model: 'MiniMax', instance: mini_max_client, default: false },
        { model: '文心一言4(baidu)', instance: llama_ernie_bot_four_client, default: false },
        { model: '文心一言4(智增增)', instance: smarttrot_ernie_bot_4_client, default: true },
        { model: '文心一言(baidu)', instance: llama_ernie_bot_client, default: true },
        { model: '文心一言turbo(baidu)', instance: llama_ernie_bot_turbo_client, default: true },
        { model: '通义千问', instance: qwen_plus_client, default: true },
        { model: '通义千问turbo', instance: qwen_turbo_client, default: true },
        { model: 'llama_7b(baidu)', instance: llama_7b_client, default: true },
        { model: 'llama_13b(baidu)', instance: llama_13b_client, default: true },
        { model: 'llama_70b(baidu)', instance: llama_70b_client, default: true },
        { model: 'llama_7b(theb.ai)', instance: thebai_llama_7b_client, default: false },
        { model: 'llama_13b(theb.ai)', instance: thebai_llama_13b_client, default: false },
        { model: 'llama_70b(theb.ai)', instance: thebai_llama_70b_client, default: false },
        { model: 'moonshot_v1_8k', instance: moonshot_v1_8k_client, default: false },
        { model: 'gemini_v1_pro', instance: gemini_v1_pro_client, default: false },
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

    def llama_ernie_bot_four_client
      Bot::ErnieBotFour.new(ENV.fetch("BAIDU_API_KEY"), ENV.fetch("BAIDU_SECRET_KEY"), ENV.fetch("BAIDU_API_BASE_URL"))
    end

    def llama_ernie_bot_client
      Bot::ErnieBot.new(ENV.fetch("BAIDU_API_KEY"), ENV.fetch("BAIDU_SECRET_KEY"), ENV.fetch("BAIDU_API_BASE_URL"))
    end

    def llama_ernie_bot_turbo_client
      Bot::ErnieBotTurbo.new(ENV.fetch("BAIDU_API_KEY"), ENV.fetch("BAIDU_SECRET_KEY"), ENV.fetch("BAIDU_API_BASE_URL"))
    end

    def mini_max_client
      Bot::MiniMax.new(ENV.fetch("MINIMAX_GROUP_ID"), ENV.fetch("MINIMAX_SECRET_KEY"), ENV.fetch("MINIMAX_API_BASE_URL"))
    end

    def thebai_llama_7b_client
      Bot::ThebaiLlama7b.new(ENV.fetch("THEBAI_API_KEY"), ENV.fetch("THEBAI_API_BASE_URL"))
    end

    def thebai_llama_13b_client
      Bot::ThebaiLlama13b.new(ENV.fetch("THEBAI_API_KEY"), ENV.fetch("THEBAI_API_BASE_URL"))
    end

    def thebai_llama_70b_client
      Bot::ThebaiLlama70b.new(ENV.fetch("THEBAI_API_KEY"), ENV.fetch("THEBAI_API_BASE_URL"))
    end

    def thebai_claude_2_client
      Bot::ClaudeTwo.new(ENV.fetch("THEBAI_API_KEY"), ENV.fetch("THEBAI_API_BASE_URL"))
    end

    def thebai_claude_1_100k_client
      Bot::ClaudeOneOneHundredK.new(ENV.fetch("THEBAI_API_KEY"), ENV.fetch("THEBAI_API_BASE_URL"))
    end

    def thebai_search_client
      Bot::Search.new(ENV.fetch("THEBAI_API_KEY"), ENV.fetch("THEBAI_API_BASE_URL"))
    end

    def qwen_plus_client
      Bot::QwenPlus.new(ENV.fetch("ALI_API_KEY"), ENV.fetch("ALI_API_BASE_URL"))
    end

    def qwen_turbo_client
      Bot::QwenTurbo.new(ENV.fetch("ALI_API_KEY"), ENV.fetch("ALI_API_BASE_URL"))
    end

    def moonshot_v1_8k_client
      Bot::V18k.new(ENV.fetch("MOONSHOT_API_KEY"), ENV.fetch("MOONSHOT_API_BASE_URL"))
    end

    def gemini_v1_pro_client
      Bot::V1Pro.new(ENV.fetch("GEMINI_API_KEY"), ENV.fetch("GEMINI_API_BASE_URL"))
    end

    def smarttrot_gpt_3_5_client
      Bot::Smarttrot::Gpt3_5.new(ENV.fetch("SMARTTROT_API_KEY"), ENV.fetch("SMARTTROT_API_BASE_URL"))
    end

    def smarttrot_gpt_4_0_client
      Bot::Smarttrot::Gpt4.new(ENV.fetch("SMARTTROT_API_KEY"), ENV.fetch("SMARTTROT_API_BASE_URL"))
    end

    def smarttrot_claude_1_client
      Bot::Smarttrot::Cloude_1_100k.new(ENV.fetch("SMARTTROT_API_KEY"), ENV.fetch("SMARTTROT_API_BASE_URL"))
    end

    def smarttrot_claude_2_client
      Bot::Smarttrot::Cloude_2_100k.new(ENV.fetch("SMARTTROT_API_KEY"), ENV.fetch("SMARTTROT_API_BASE_URL"))
    end

    def smarttrot_ernie_bot_4_client
      Bot::Smarttrot::ERNIEBot4.new(ENV.fetch("SMARTTROT_API_KEY"), ENV.fetch("SMARTTROT_API_BASE_URL"))
    end
  end
end