class AddBlockToSection < ActiveRecord::Migration[6.0]
  def change
    add_column :sections, :block, :integer
  end
end
