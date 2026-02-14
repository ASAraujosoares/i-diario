class AddUserIdToTransferNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :transfer_notes, :user_id, :integer, index: true, null: false
    add_foreign_key :transfer_notes, :users
  end
end
