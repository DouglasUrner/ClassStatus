class CreateTermNames < ActiveRecord::Migration[6.0]
  def change
    create_table :term_names do |t|
      t.string :name
      t.string :short_name

      t.timestamps
    end
  end
end
