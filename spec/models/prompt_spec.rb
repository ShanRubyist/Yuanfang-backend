require 'rails_helper'

RSpec.describe Api::V1::Prompt, type: :model do
  before do
    @prompt = FactoryBot.create(:prompt)
  end

  it 'should respond to #content' do
    expect(@prompt).to respond_to(:content)
    expect(@prompt.content).to eq 'prompt content'
  end
end
