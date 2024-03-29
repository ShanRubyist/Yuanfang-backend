class CreateAchieveAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :achieve_answers do |t|
      t.references :achieve_question, null: false
      t.string :site, null: false
      t.text :respond
      t.json :original_respond

      t.timestamps
    end
  end
end
