require 'bots/thebai'

module Bot
  class Search < Thebai
    def initialize(api_key, api_base_url = 'https://api.theb.ai')
      super
      @path = '/v1/search/completions'
    end
  end
end