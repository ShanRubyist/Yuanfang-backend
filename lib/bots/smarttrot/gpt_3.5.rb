require 'bots/smarttrot'

module Bot
  module Smarttrot
    class Gpt3_5 < Openai
      def initialize(api_key, api_base_url = 'https://api.openai.com/', organization_id = '')
        super
        @model = 'gpt-3.5-turbo-1106'
      end
    end
  end
end