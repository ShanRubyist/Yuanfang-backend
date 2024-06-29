class CreateApiV1Prompts < ActiveRecord::Migration[7.0]
  def change
    create_table :api_v1_prompts, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.uuid :user, null: false
      t.string :content, null: false
      t.timestamps
    end
  end
end
