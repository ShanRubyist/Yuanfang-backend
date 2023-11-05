require 'bots/ali'

module Bot
  class QwenPlus < Ali
    def initialize(api_key, api_base_url = 'https://dashscope.aliyuncs.com')
      super
      @model = 'qwen-plus'
    end
  end
end