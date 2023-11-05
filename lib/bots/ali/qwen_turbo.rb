require 'bots/ali'

module Bot
  class QwenTurbo < Ali
    def initialize(api_key, api_base_url = 'https://dashscope.aliyuncs.com')
      super
      @model = 'qwen-turbo'
    end
  end
end