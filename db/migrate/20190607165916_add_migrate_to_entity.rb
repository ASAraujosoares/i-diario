class AddMigrateToEntity < ActiveRecord::Migration[5.2]
  def change
    add_column :entities, :migrate, :boolean, null: false, default: true
  end
end
