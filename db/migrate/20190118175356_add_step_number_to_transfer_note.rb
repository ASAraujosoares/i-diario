class AddStepNumberToTransferNote < ActiveRecord::Migration[5.2]
  def change
    add_column :transfer_notes, :step_number, :integer, null: false, default: 0
  end
end
