class AddDisabledSyncToEntities < ActiveRecord::Migration[5.2]
  def change
    add_column :entities, :disabled_sync, :boolean, default: false
  end
end
