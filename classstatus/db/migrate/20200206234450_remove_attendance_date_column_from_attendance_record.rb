class RemoveAttendanceDateColumnFromAttendanceRecord < ActiveRecord::Migration[6.0]
  def change
    remove_column :attendance_records, :attendance_date
  end
end
