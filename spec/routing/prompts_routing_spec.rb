require 'rails_helper'

RSpec.describe 'Api::V1::PromptsController', type: :routing do
  describe 'routing' do

    it 'routes to #default' do
      expect(get: "/api/v1/prompts/default").to route_to("api/v1/prompts#get_default_prompt")
    end

    it 'routes to #default' do
      expect(post: "/api/v1/prompts/default").to route_to("api/v1/prompts#set_default_prompt")
    end

  end
end