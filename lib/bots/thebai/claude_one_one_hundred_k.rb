require 'bots/thebai'

module Bot
  class ClaudeOneOneHundredK < Thebai
    def initialize(api_key, api_base_url = 'https://api.theb.ai')
      super
      @model = 'claude-1-100k'
    end
  end
end