class AddStateColumnToEnrollment < ActiveRecord::Migration[6.0]
  def change
    add_column :enrollments, :state, :string
  end
end
