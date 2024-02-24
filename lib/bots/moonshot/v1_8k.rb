require 'bots/moonshot'

module Bot
  class V18k < Moonshot
    def initialize(api_key, api_base_url = 'https://api.moonshot.cn')
      super
      @model = 'moonshot-v1-8k'
    end
  end
end