class RemoveStateColumnFromEnrollment < ActiveRecord::Migration[6.0]
  def change
    remove_column :enrollments, :state
  end
end
