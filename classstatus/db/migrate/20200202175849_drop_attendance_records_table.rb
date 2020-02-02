class DropAttendanceRecordsTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :attendance_records
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
