require 'bots/baidu'

module Bot
  class ErnieBot < Baidu
    def initialize(api_key, secret_key, api_base_url = 'https://aip.baidubce.com')
      super
      @path = '/rpc/2.0/ai_custom/v1/wenxinworkshop/chat/completions'
    end
  end
end