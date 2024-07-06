require 'bots/thebai'

module Bot
  class ClaudeSonnet < Thebai
    def initialize(api_key, api_base_url = 'https://api.theb.ai')
      super
      @model = 'claude-3.5-sonnet'
    end
  end
end