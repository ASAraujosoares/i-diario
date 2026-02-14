class AddDiscardedAtToStudent < ActiveRecord::Migration[5.2]
  def up
    add_column :students, :discarded_at, :datetime
    add_index :students, :discarded_at
  end

  def down
    remove_column :students, :discarded_at
  end
end
