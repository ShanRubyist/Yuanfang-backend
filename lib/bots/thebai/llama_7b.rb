require 'bots/thebai'

module Bot
  class ThebaiLlama7b < Thebai
    def initialize(api_key, api_base_url = 'https://api.theb.ai')
      super
      @model = 'llama-2-7b-chat'
    end
  end
end