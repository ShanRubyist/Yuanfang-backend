class Api::V1::PromptsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_api_v1_prompt, only: %i[ show update destroy ]

  def get_default_prompt
    default_prompt_id = current_user.default_prompt_id
    content = current_user.api_v1_prompts.find(default_prompt_id).content if default_prompt_id

    render json: {
      default_prompt: {
        id: default_prompt_id,
        content: content
      }
    }
  end

  def set_default_prompt
    current_user.update(default_prompt_id: params[:prompt_id])
    render status: 200
  end

  # GET /api/v1/prompts
  def index
    @api_v1_prompts = current_user.api_v1_prompts.all
    default_prompt_id = current_user.default_prompt_id

    prompts = @api_v1_prompts.map do |prompt|
      {
        id: prompt.id,
        content: prompt.content,
        default: default_prompt_id == prompt.id
      }
    end

    render json: prompts
  end

  # GET /api/v1/prompts/1
  def show
    render json: @api_v1_prompt
  end

  # POST /api/v1/prompts
  def create
    @api_v1_prompt = current_user.api_v1_prompts.new(api_v1_prompt_params)

    if @api_v1_prompt.save
      current_user.update(default_prompt_id: @api_v1_prompt.id) if params["default"]
      render json: @api_v1_prompt, status: :created, location: @api_v1_prompt
    else
      render json: @api_v1_prompt.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/prompts/1
  def update
    if @api_v1_prompt.update(api_v1_prompt_params)
      render json: @api_v1_prompt
    else
      render json: @api_v1_prompt.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/prompts/1
  def destroy
    @api_v1_prompt.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_api_v1_prompt
    @api_v1_prompt = current_user.api_v1_prompts.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def api_v1_prompt_params
    params.require('prompt').permit(:content)
    # params.fetch(:api_v1_prompt, {})
  end
end
