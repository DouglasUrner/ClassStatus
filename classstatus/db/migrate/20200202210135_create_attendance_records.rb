class CreateAttendanceRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :attendance_records do |t|
      t.references :student, null: false, foreign_key: true
      t.references :section, null: false, foreign_key: true
      t.date :attendance_date
      t.timestamp :attendance_entered
      t.string :state

      t.timestamps
    end
  end
end
