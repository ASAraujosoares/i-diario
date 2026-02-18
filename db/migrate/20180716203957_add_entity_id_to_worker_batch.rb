class AddEntityIdToWorkerBatch < ActiveRecord::Migration[5.2]
  def change
    add_column :worker_batches, :entity_id, :integer
  end
end
