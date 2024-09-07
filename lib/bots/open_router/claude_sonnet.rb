require 'bots/open_router'

module Bot
  module OpenRouter
    class ClaudeSonnet < OpenRouter
      def initialize(api_key, api_base_url = 'https://open_router.ai')
        super
        @model = 'anthropic/claude-3.5-sonnet'
      end
    end
  end
end