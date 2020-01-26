class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.references :course, null: false, foreign_key: true
      t.references :year, null: false, foreign_key: true
      t.references :term, null: false, foreign_key: true
      t.references :block, null: false, foreign_key: true

      t.timestamps
    end
  end
end
