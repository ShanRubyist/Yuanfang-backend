require 'bots/baidu'

module Bot
  class Llama70b < Baidu
    def initialize(api_key, secret_key, api_base_url = 'https://aip.baidubce.com')
      super
      @path = '/rpc/2.0/ai_custom/v1/wenxinworkshop/chat/llama_2_70b'
    end
  end
end