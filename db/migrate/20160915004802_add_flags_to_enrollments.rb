class AddFlagsToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :completed, :boolean, :default => false
    add_column :enrollments, :expositions_completed, :boolean, :default => false
    add_column :enrollments, :unscrambled_completed, :boolean, :default => false
    add_column :enrollments, :dictation_completed, :boolean, :default => false
    add_column :enrollments, :image_spelling_completed, :boolean, :default => false
  end
end
