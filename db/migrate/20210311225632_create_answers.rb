class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.text :entry
      t.integer :owner_id
      t.string :image
      t.integer :question_id
      t.integer :decoratations_count
      t.integer :comments_count

      t.timestamps
    end
  end
end
