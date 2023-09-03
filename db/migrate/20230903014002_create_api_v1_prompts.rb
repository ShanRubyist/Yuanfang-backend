class CreateApiV1Prompts < ActiveRecord::Migration[7.0]
  def change
    create_table :api_v1_prompts do |t|
      t.references :user, null: false
      t.string :content, null: false
      t.timestamps
    end
  end
end
