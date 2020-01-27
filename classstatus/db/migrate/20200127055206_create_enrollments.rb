class CreateEnrollments < ActiveRecord::Migration[6.0]
  def change
    create_table :enrollments do |t|
      t.references :student
      t.references :section
      t.integer :status

      t.timestamps
    end
  end
end
