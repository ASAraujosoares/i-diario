class AddJobIdToIeducarApiSynchronization < ActiveRecord::Migration[5.2]
  def change
    add_column :ieducar_api_synchronizations, :job_id, :string
  end
end
