class FixAttendanceDate < ActiveRecord::Migration[6.0]
  def change
    add_column :attendance_records, :attendance_date, :date
    remove_column :attendance_records, :attendance_entered
  end
end
