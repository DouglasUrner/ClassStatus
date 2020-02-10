class CreateEnrollments < ActiveRecord::Migration[6.0]
  def change
    create_table :enrollments do |t|
      t.references :student, null: false, foreign_key: true
      t.references :section, null: false, foreign_key: true
      t.date :joined_course
      t.date :joined_section
      t.date :dropped_course

      t.timestamps
    end
  end
end
