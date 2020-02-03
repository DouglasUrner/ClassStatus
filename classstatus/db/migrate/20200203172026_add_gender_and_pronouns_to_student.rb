class AddGenderAndPronounsToStudent < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :gender, :string
    add_column :students, :pronouns, :string
  end
end
