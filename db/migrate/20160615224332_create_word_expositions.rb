class CreateWordExpositions < ActiveRecord::Migration
  def change
    create_table :word_expositions do |t|
      t.integer :enrollment_id
      t.integer :word_id
      t.boolean :completed, default: false

      t.timestamps null: false
    end
  end
end
