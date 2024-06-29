class AddDefaultPromptIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :default_prompt_id, :uuid , default: nil, comment: '用户的默认 prompt'
  end
end
