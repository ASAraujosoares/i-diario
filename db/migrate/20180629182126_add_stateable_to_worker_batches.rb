class AddStateableToWorkerBatches < ActiveRecord::Migration[5.2]
  def change
    add_reference :worker_batches, :stateable, polymorphic: true, index: true
  end
end
