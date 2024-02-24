require 'bots/smarttrot'

module Bot
  module Smarttrot
    class Gpt3_5 < Smarttrot
      def initialize(api_key, api_base_url = 'https://flag.smarttrot.com')
        super
        @model = 'gpt-3.5-turbo-1106'
      end
    end
  end
end