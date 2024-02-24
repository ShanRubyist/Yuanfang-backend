require 'bots/smarttrot'

module Bot
  module Smarttrot
    class Gpt4 < Openai
      def initialize(api_key, api_base_url = 'https://api.openai.com/', organization_id = '')
        super
        @model = 'gpt-4-1106-preview'
      end
    end
  end
end