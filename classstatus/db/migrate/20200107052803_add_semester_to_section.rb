class AddSemesterToSection < ActiveRecord::Migration[6.0]
  def change
    add_column :sections, :semester, :string
    add_column :sections, :year, :string
  end
end
