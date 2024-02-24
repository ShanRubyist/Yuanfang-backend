require 'bots/smarttrot'

module Bot
  module Smarttrot
    class ERNIEBot4 < Smarttrot
      def initialize(api_key, api_base_url = 'https://flag.smarttrot.com')
        super
        @model = 'ERNIE-Bot-4'
      end
    end
  end
end