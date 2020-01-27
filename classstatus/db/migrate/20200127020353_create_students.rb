class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.string :guid
      t.string :preferred_name
      t.string :given_name
      t.date :dob
      t.int :cohort
      t.float :gpa
      t.datetime :gpa_updated

      t.timestamps
    end
    add_index :students, :guid, unique: true
  end
end
