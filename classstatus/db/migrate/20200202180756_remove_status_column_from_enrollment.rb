class RemoveStatusColumnFromEnrollment < ActiveRecord::Migration[6.0]
  def change
    remove_column :enrollments, :status
  end
end
