class CreateUserPromptShips < ActiveRecord::Migration[7.0]
  def change
    create_table :user_prompt_ships do |t|
      t.references :user, null: false
      t.references :prompt, null: false
      t.timestamps
    end

    add_index :user_prompt_ships, [:user_id, :prompt_id], unique: true
  end
end