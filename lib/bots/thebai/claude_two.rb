require 'bots/thebai'

module Bot
  class ClaudeTwo < Thebai
    def initialize(api_key, api_base_url = 'https://api.theb.ai')
      super
      @model = 'claude-2'
    end
  end
end