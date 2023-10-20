module Bot
  class AIModel
    def initialize(api_key, api_base_url)
      @api_key = api_key
      @api_base_url = api_base_url
    end

    def completion(message, prompt = nil, options = {}, &block)
      handle(message, prompt, options) do |chunk, _bytesize|
        rst = resp(chunk)
        yield rst if @stream && rst
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
require 'bots/baidu/ernie_bot_four'
require 'bots/baidu/ernie_bot_turbo'
require 'bots/mini_max'
require 'bots/thebai/llama_7b'
require 'bots/thebai/llama_13b'
require 'bots/thebai/llama_70b'
require 'bots/thebai/claude_two'
require 'bots/thebai/claude_one_one_hundred_k'
require 'bots/thebai/search'
