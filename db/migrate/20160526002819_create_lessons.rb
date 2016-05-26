class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.text :description
      t.string :subject
      t.integer :difficulty
      t.integer :user_id
      t.timestamps null: false
    end

    add_index :lessons, :user_id
  end
end
