class DropColumnErrorMessageFromWorkerStates < ActiveRecord::Migration[5.2]
  def change
    remove_column :worker_states, :error_message
  end
end
