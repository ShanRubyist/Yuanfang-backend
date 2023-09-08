module Bot
  class AIModel
    def initialize(api_key, api_base_url)
      @api_key = api_key
      @api_base_url = api_base_url
    end

    def completion(message, prompt = nil, options = {}, &block)
      handle(message, prompt, options) do |chunk, _bytesize|
        yield resp(chunk) if @stream
      end
    end

    private

    def resp(msg)
      msg
    end
  end
end

require 'bots/openai/gpt_three_point_five'
require 'bots/openai/gpt_four_point_zero'
require 'bots/baidu/llama_7b'
require 'bots/baidu/llama_13b'
require 'bots/baidu/llama_70b'
require 'bots/baidu/ernie_bot'
require 'bots/baidu/ernie_bot_turbo'
