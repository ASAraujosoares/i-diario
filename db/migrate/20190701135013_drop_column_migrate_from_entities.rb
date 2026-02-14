class DropColumnMigrateFromEntities < ActiveRecord::Migration[5.2]
  def change
    remove_column :entities, :migrate, :boolean
  end
end
