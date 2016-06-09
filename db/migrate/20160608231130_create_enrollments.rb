class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :user_id
      t.integer :lesson_id
      t.timestamps null: false
    end

    add_index :enrollments, [:user_id, :lesson_id]
    add_index :enrollments, :lesson_id
  end
end
