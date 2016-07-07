class CreateWordImageMatches < ActiveRecord::Migration
  def change
    create_table :word_image_matches do |t|
      t.integer  "enrollment_id", index: true
      t.integer  "word_id", index: true
      t.boolean  "completed", default: false
      t.timestamps null: false
    end
  end
end
