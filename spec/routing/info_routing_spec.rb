require 'rails_helper'

RSpec.describe 'Api::V1::InfoController', type: :routing do
  describe 'routing' do
    it 'routes to #models' do
      expect(get: "/api/v1/info/models").to route_to("api/v1/info#models")
    end
  end
end