class CreateEnrollments < ActiveRecord::Migration[6.0]
  def change
    create_table :enrollments do |t|
      t.reference :student
      t.reference :section
      t.integer :status

      t.timestamps
    end
  end
end
