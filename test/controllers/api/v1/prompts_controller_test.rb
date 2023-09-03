require "test_helper"

class Api::V1::PromptsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_v1_prompt = api_v1_prompts(:one)
  end

  test "should get index" do
    get api_v1_prompts_url, as: :json
    assert_response :success
  end

  test "should create api_v1_prompt" do
    assert_difference("Api::V1::Prompt.count") do
      post api_v1_prompts_url, params: { api_v1_prompt: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show api_v1_prompt" do
    get api_v1_prompt_url(@api_v1_prompt), as: :json
    assert_response :success
  end

  test "should update api_v1_prompt" do
    patch api_v1_prompt_url(@api_v1_prompt), params: { api_v1_prompt: {  } }, as: :json
    assert_response :success
  end

  test "should destroy api_v1_prompt" do
    assert_difference("Api::V1::Prompt.count", -1) do
      delete api_v1_prompt_url(@api_v1_prompt), as: :json
    end

    assert_response :no_content
  end
end
