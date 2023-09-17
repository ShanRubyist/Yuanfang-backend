require 'bots/thebai'

module Bot
  class ThebaiLlama13b < Thebai
    def initialize(api_key, api_base_url = 'https://api.theb.ai')
      super
      @model = 'llama-2-13b-chat'
    end
  end
end