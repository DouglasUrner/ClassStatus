class AddColumnsToStudent < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :cohort, :integer
    add_column :students, :dob, :date
    add_column :students, :gender, :string
    add_column :students, :known_to, :string
  end
end
