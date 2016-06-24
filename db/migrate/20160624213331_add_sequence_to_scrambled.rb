class AddSequenceToScrambled < ActiveRecord::Migration
  def change
    add_column :scrambled_words, :sequence, :integer
  end
end
