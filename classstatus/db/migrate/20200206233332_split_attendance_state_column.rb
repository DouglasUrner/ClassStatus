class SplitAttendanceStateColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :attendance_records, :state, :primary
    add_column :attendance_records, :secondary, :string
  end
end
