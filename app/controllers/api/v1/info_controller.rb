class Api::V1::InfoController < ApplicationController
  def models
    models = [
      { label: 'gpt-3.5-turbo(openai)', model: 'gpt-3.5-turbo', site: 'openai', default: false },
      { label: 'gpt-3.5-turbo(api2d.net)', model: 'gpt-3.5-turbo', site: 'api2d', default: true},
      { label: 'gpt-3.5-turbo(ai.ls)', model: 'gpt-3.5-turbo', site: 'ai.ls', default: true },
      { label: 'gpt-4(api2d.net)', model: 'gpt-4', site: 'api2d', default: false },
      { label: 'gpt-4(ai.ls)', model: 'gpt-4', site: 'ai.ls', default: false },
    ]

    render json: models.to_json
  end
end
