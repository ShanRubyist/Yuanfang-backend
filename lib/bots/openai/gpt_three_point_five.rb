require 'bots/openai'

module Bot
  class GptThreePointFive < Openai
  def initialize(api_key, api_base_url = 'https://api.openai.com/', organization_id = '')
      super
      @model = 'gpt-3.5-turbo'
    end
  end
end