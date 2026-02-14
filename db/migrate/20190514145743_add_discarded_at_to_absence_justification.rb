class AddDiscardedAtToAbsenceJustification < ActiveRecord::Migration[5.2]
  def up
    add_column :absence_justifications, :discarded_at, :datetime
    add_index :absence_justifications, :discarded_at
  end

  def down
    remove_column :absence_justifications, :discarded_at
  end
end
