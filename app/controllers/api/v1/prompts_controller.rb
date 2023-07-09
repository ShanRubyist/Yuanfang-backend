class Api::V1::PromptsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: current_user.prompts
  end

  def create
    raise 'prompt content can not be empty' unless params['content'].present?

    prompt = current_user.prompts.create(prompt_params)
    if prompt
      render json: prompt
    else
      render json: {'message': 'Create failed'}, status: 500
    end
  end

  def update
    raise 'prompt content can not be empty' unless params['content'].present?

    prompt = current_user.prompts.find(params['id'])
    if prompt && prompt.update(content: params['content'])
      render json: {'message': 'Update success'}
    else
      render json: {'message': 'Update failed'}, status: 500
    end
  end

  def destroy
    prompt = Prompt.find(params['id'])
    # current_user.prompts.destroy(prompt) 只删除关联的记录， 不会删除 prompts 表里面的对象，还需要 prompt.destroy
    if current_user.prompts.destroy(prompt) && prompt.destroy
      render json: {'message': 'Delete success'}
    else
      render json: {'message': 'Delete failed'}, status: 500
    end
  end

  private

  def prompt_params
    params[:prompt][:content] = params['content']

    params.require(:prompt).permit(:content)
  end
end
