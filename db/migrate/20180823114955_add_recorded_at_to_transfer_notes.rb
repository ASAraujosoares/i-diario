class AddRecordedAtToTransferNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :transfer_notes, :recorded_at, :date
  end
end
