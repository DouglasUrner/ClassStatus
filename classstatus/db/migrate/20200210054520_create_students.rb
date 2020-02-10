class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.string :guid
      t.string :preferred_name
      t.string :given_name
      t.string :family_name
      t.string :pronouns
      t.string :gender
      t.date :dob
      t.integer :cohort
      t.float :gpa
      t.timestamp :gpa_updated

      t.timestamps
    end
    add_index :students, :guid, unique: true
  end
end
