class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :term
      t.string :reference

      t.integer :lesson_id
      t.timestamps null: false
    end

    add_index :words, :lesson_id
  end
end
