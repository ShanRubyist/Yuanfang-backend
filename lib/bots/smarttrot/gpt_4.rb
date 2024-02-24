require 'bots/smarttrot'

module Bot
  module Smarttrot
    class Gpt4 < Smarttrot
      def initialize(api_key, api_base_url = 'https://flag.smarttrot.com')
        super
        @model = 'gpt-4-1106-preview'
      end
    end
  end
end