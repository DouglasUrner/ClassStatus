class ChangeGuidToString < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      change_table :students do |t|
        dir.up   { t.change :guid, :string }
        dir.down { t.change :guid, :integer }
      end
    end
  end
end
