class CreateImageSpellings < ActiveRecord::Migration
  def change
    create_table :image_spellings do |t|
      t.integer  "enrollment_id", index: true
      t.integer  "word_id", index: true
      t.boolean  "completed", default: false
      t.integer "sequence"
      t.timestamps null: false
    end
  end
end
