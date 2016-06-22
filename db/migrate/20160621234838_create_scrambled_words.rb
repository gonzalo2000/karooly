class CreateScrambledWords < ActiveRecord::Migration
  def change
    create_table :scrambled_words do |t|
      t.integer :enrollment_id
      t.integer :word_id
      t.boolean :completed, default: false
      
      t.timestamps null: false
    end
  end
end
