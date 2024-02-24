require 'bots/smarttrot'

module Bot
  module Smarttrot
    class Cloude_1_100k < Smarttrot
      def initialize(api_key, api_base_url = 'https://flag.smarttrot.com')
        super
        @model = 'claude-1-100k'
      end
    end
  end
end