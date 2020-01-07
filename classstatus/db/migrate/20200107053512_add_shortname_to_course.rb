class AddShortnameToCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :shortname, :string
  end
end
