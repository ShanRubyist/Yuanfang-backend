class Api::V1::InfoController < ApplicationController
  include ModelMap

  def models
    models = MODEL_NAME_2_INSTANCE.map do |item|
      {
        model: item.fetch(:model),
        default: item.fetch(:default)
      }
    end

    render json: models.to_json
  end
end
