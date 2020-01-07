class AddFlagToEnrollment < ActiveRecord::Migration[6.0]
  def change
    add_column :enrollments, :active, :boolean
  end
end
