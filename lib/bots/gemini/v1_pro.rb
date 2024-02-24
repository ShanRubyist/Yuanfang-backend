require 'bots/gemini'

module Bot
  class V1Pro < Gemini
    def initialize(api_key, api_base_url = 'https://generativelanguage.googleapis.com')
      super

    end
  end
end