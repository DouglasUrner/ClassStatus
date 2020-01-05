class AddIndexToStudents < ActiveRecord::Migration[6.0]
  def change
    # add_column :students, :guid, :string
    add_index :students, :guid, unique: true
  end
end
