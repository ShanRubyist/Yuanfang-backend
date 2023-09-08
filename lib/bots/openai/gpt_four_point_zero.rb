require 'bots/openai'

module Bot
  class GptFourPointZero < Openai
  def initialize(api_key, api_base_url = 'https://api.openai.com/', organization_id = '')
      super
      @model = 'gpt-4'
    end
  end
end