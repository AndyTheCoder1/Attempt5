class CreateDecoratations < ActiveRecord::Migration[6.0]
  def change
    create_table :decoratations do |t|
      t.integer :user_id
      t.integer :answer_id

      t.timestamps
    end
  end
end
