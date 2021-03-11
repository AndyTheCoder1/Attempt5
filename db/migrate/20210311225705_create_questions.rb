class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.text :question
      t.integer :answers_count

      t.timestamps
    end
  end
end
