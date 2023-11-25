require 'rails_helper'

RSpec.describe 'Api::V1::CompletionsController', type: :routing do
  describe 'routing' do

    it 'routes to #achieve' do
      expect(post: "/api/v1/completions/achieve").to route_to("api/v1/completions#achieve")
    end

  end
end