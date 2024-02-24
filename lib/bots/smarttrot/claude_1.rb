require 'bots/smarttrot'

module Bot
  module Smarttrot
    class Cloude_1_100k < Openai
      def initialize(api_key, api_base_url = 'https://api.openai.com/', organization_id = '')
        super
        @model = 'claude-1-100k'
      end
    end
  end
end