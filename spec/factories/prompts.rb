FactoryBot.define do
  factory :prompt, class: 'Api::V1::Prompt' do
    association :user
    content { 'prompt content'}
  end
end