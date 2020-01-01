class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.string :given_name
      t.string :family_name
      t.string :preferred_name
      t.string :pronouns
      t.string :github_user

      t.timestamps
    end
  end
end
