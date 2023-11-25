require 'rails_helper'

RSpec.describe 'ApplicationController', type: :routing do
  describe 'routing' do

    it 'routes to #cors_preflight_check' do
      expect(options: "/auth/sign_in").to route_to("application#cors_preflight_check")
    end

  end
end