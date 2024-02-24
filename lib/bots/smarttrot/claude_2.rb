require 'bots/smarttrot'

module Bot
  module Smarttrot
    class Cloude_2_100k < Smarttrot
      def initialize(api_key, api_base_url = 'https://flag.smarttrot.com')
        super
        @model = 'claude-2-100k'
      end
    end
  end
end