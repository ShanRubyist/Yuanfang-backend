class CreateAchieveQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :achieve_questions do |t|
      t.references :user, null: false
      t.uuid :achieve_id, null: false
      t.text :question, null: false
      t.text :prompt
      t.json :origin_params

      t.timestamps
    end

    add_index :achieve_questions, :achieve_id
  end
end
