class AddDiscardedAtToTransferNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :transfer_notes, :discarded_at, :datetime
  end
end
