class AddJoinedAndDroppedFieldsToEnrollment < ActiveRecord::Migration[6.0]
  def change
    add_column :enrollments, :joined_course, :date
    add_column :enrollments, :joined_section, :date
    add_column :enrollments, :dropped_course, :date
  end
end
