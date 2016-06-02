class AddSoundToWords < ActiveRecord::Migration
  def change
    add_column :words, :sound, :string
  end
end
