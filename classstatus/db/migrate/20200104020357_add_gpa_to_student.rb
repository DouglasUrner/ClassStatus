class AddGpaToStudent < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :gpa, :float
  end
end
