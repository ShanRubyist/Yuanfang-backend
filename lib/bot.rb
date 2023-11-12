module Bot
  class AIModel
    def initialize(api_key, api_base_url)
      @api_key = api_key
      @api_base_url = api_base_url
    end

    def completion(message, prompt = nil, options = {}, &block)
      handle(message, prompt, options) do |chunk, _overall_received_bytes, _env|
        fail chunk.to_s if _env && _env.status != 200

        if @stream
          rst = resp(chunk)
          if rst.is_a?(Array)
            rst.each { |item| yield item, chunk }
          elsif rst
            yield rst, chunk
          end
        end
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
require 'bots/ali/qwen_plus'
require 'bots/ali/qwen_turbo'
